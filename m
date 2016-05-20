Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] iowatcher: Add sample script to tag IO by process and allow grouping
Date: Fri, 20 May 2016 13:54:59 +0200
Message-Id: <1463745299-5951-4-git-send-email-jack@suse.cz>
In-Reply-To: <1463745299-5951-1-git-send-email-jack@suse.cz>
References: <1463745299-5951-1-git-send-email-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Add a python module iowatcher.py that implements communication with
the main iowatcher program. Also add a simple python script that tags
IO by process ID and also allows grouping of processes into groups
to demonstrate the use of the script.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 iowatcher/iowatcher.py  | 141 ++++++++++++++++++++++++++++++++++++++++++++++++
 iowatcher/tag-by-pid.py |  64 ++++++++++++++++++++++
 2 files changed, 205 insertions(+)
 create mode 100755 iowatcher/iowatcher.py
 create mode 100755 iowatcher/tag-by-pid.py

diff --git a/iowatcher/iowatcher.py b/iowatcher/iowatcher.py
new file mode 100755
index 000000000000..bfc6e01f8744
--- /dev/null
+++ b/iowatcher/iowatcher.py
@@ -0,0 +1,141 @@
+import struct
+import os
+import sys
+
+"""
+We read input in the following form:
+struct blk_io_trace {
+        __u32 magic;            /* MAGIC << 8 | version */
+        __u32 sequence;         /* event number */
+        __u64 time;             /* in nanoseconds */
+        __u64 sector;           /* disk offset */
+        __u32 bytes;            /* transfer length */
+        __u32 action;           /* what happened */
+        __u32 pid;              /* who did it */
+        __u32 device;           /* device identifier (dev_t) */
+        __u32 cpu;              /* on what cpu did it happen */
+        __u16 error;            /* completion error */
+        __u16 pdu_len;          /* length of data after this trace */
+}; => size 48 bytes
+"""
+
+# Basic trace action constants
+__BLK_TA_QUEUE = 1
+__BLK_TA_BACKMERGE = 2
+__BLK_TA_FRONTMERGE = 3
+__BLK_TA_GETRQ = 4
+__BLK_TA_SLEEPRQ = 5
+__BLK_TA_REQUEUE = 6
+__BLK_TA_ISSUE = 7
+__BLK_TA_COMPLETE = 8
+__BLK_TA_PLUG = 9
+__BLK_TA_UNPLUG_IO = 10
+__BLK_TA_UNPLUG_TIMER = 11
+__BLK_TA_INSERT = 12
+__BLK_TA_SPLIT = 13
+__BLK_TA_BOUNCE = 14
+__BLK_TA_REMAP = 15
+__BLK_TA_ABORT = 16
+__BLK_TA_DRV_DATA = 17
+
+# Notification events constants
+__BLK_TN_PROCESS = 0
+__BLK_TN_TIMESTAMP = 1
+__BLK_TN_MESSAGE = 2
+
+# Trace categories
+BLK_TC_READ     = 1 << 0
+BLK_TC_WRITE    = 1 << 1
+BLK_TC_FLUSH    = 1 << 2
+BLK_TC_SYNC     = 1 << 3
+BLK_TC_QUEUE    = 1 << 4
+BLK_TC_REQUEUE  = 1 << 5
+BLK_TC_ISSUE    = 1 << 6
+BLK_TC_COMPLETE = 1 << 7
+BLK_TC_FS       = 1 << 8
+BLK_TC_PC       = 1 << 9
+BLK_TC_NOTIFY   = 1 << 10
+BLK_TC_AHEAD    = 1 << 11
+BLK_TC_META     = 1 << 12
+BLK_TC_DISCARD  = 1 << 13
+BLK_TC_DRV_DATA = 1 << 14
+BLK_TC_FUA      = 1 << 15
+
+BLK_TC_SHIFT = 16
+BLK_TA_MASK = (1 << BLK_TC_SHIFT) - 1
+
+def BLK_TC_ACT(act):
+	return act << BLK_TC_SHIFT
+
+def BLK_DATADIR(action):
+	return (action >> BLK_TC_SHIFT) & (BLK_TC_READ | BLK_TC_WRITE)
+
+# Trace actions in full
+BLK_TA_QUEUE =		__BLK_TA_QUEUE | BLK_TC_ACT(BLK_TC_QUEUE)
+BLK_TA_BACKMERGE =	__BLK_TA_BACKMERGE | BLK_TC_ACT(BLK_TC_QUEUE)
+BLK_TA_FRONTMERGE =	__BLK_TA_FRONTMERGE | BLK_TC_ACT(BLK_TC_QUEUE)
+BLK_TA_GETRQ =		__BLK_TA_GETRQ | BLK_TC_ACT(BLK_TC_QUEUE)
+BLK_TA_SLEEPRQ =	__BLK_TA_SLEEPRQ | BLK_TC_ACT(BLK_TC_QUEUE)
+BLK_TA_REQUEUE =	__BLK_TA_REQUEUE | BLK_TC_ACT(BLK_TC_REQUEUE)
+BLK_TA_ISSUE =		__BLK_TA_ISSUE | BLK_TC_ACT(BLK_TC_ISSUE)
+BLK_TA_COMPLETE =	__BLK_TA_COMPLETE| BLK_TC_ACT(BLK_TC_COMPLETE)
+BLK_TA_PLUG =		__BLK_TA_PLUG | BLK_TC_ACT(BLK_TC_QUEUE)
+BLK_TA_UNPLUG_IO =	__BLK_TA_UNPLUG_IO | BLK_TC_ACT(BLK_TC_QUEUE)
+BLK_TA_UNPLUG_TIMER =	__BLK_TA_UNPLUG_TIMER | BLK_TC_ACT(BLK_TC_QUEUE)
+BLK_TA_INSERT =		__BLK_TA_INSERT | BLK_TC_ACT(BLK_TC_QUEUE)
+BLK_TA_SPLIT =		__BLK_TA_SPLIT
+BLK_TA_BOUNCE =		__BLK_TA_BOUNCE
+BLK_TA_REMAP =		__BLK_TA_REMAP | BLK_TC_ACT(BLK_TC_QUEUE)
+BLK_TA_ABORT =		__BLK_TA_ABORT | BLK_TC_ACT(BLK_TC_QUEUE)
+BLK_TA_DRV_DATA =	__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA)
+
+BLK_TN_PROCESS =	__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY)
+BLK_TN_TIMESTAMP =	__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY)
+BLK_TN_MESSAGE =	__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY)
+
+# Responses to iowatcher process
+TAG_RESP_END = 0
+TAG_RESP_NEW_TAG = 1
+TAG_RESP_TAG_IO = 2
+
+def safe_read(count):
+	buf = ''
+	while count > 0:
+		newbuf = os.read(0, count)
+		if len(newbuf) == 0:
+			return ''
+		count -= len(newbuf)
+		buf += newbuf
+	return buf
+
+
+def read_event():
+	buf = safe_read(48)
+	# EOF?
+	if len(buf) == 0:
+		return ()
+	fields = struct.unpack('=IIQQIIIIIHH', buf)
+	pdu_len = fields[10]
+	if pdu_len > 0:
+		buf = safe_read(pdu_len)
+		if len(buf) == 0:
+			return ()
+		fields += (buf,)
+	else:
+		fields += ('',)
+	return fields
+
+def write_response_end():
+	buf = struct.pack('=I', TAG_RESP_END)
+	os.write(1, buf)
+
+def write_response_iotag(tag):
+	buf = struct.pack('=II', TAG_RESP_TAG_IO, tag)
+	os.write(1, buf)
+
+def write_response_newtag(tag, label):
+	label += '\0'
+	plen = len(label)
+	buf = struct.pack('=III', TAG_RESP_NEW_TAG, tag, plen)
+	os.write(1, buf)
+	os.write(1, label)
diff --git a/iowatcher/tag-by-pid.py b/iowatcher/tag-by-pid.py
new file mode 100755
index 000000000000..21d1d3351cac
--- /dev/null
+++ b/iowatcher/tag-by-pid.py
@@ -0,0 +1,64 @@
+#!/usr/bin/python
+
+from __future__ import print_function
+import sys
+import iowatcher
+import getopt
+
+pid_hash = {}
+group_hash = {}
+cur_tag = 0
+cur_group = 0
+
+try:
+	opts, args = getopt.getopt(sys.argv[1:], 'g:')
+except getopt.GetoptError:
+	print('tag-by-pid.py [-g group_name:pid[,pid...]] ...', file=sys.stderr)
+	sys.exit(1)
+
+for opt, arg in opts:
+	if opt == '-g':
+		try:
+			name_end = arg.find(':')
+		except ValueError:
+			print('Cannot find end of group name in group description \'' + arg + '\'\n', file=sys.stderr)
+			sys.exit(1)
+		name = arg[:name_end]
+		arg = arg[name_end + 1:]
+		pids = arg.split(',')
+		group_id = 'g' + str(cur_group)
+		for pid in pids:
+			group_hash[int(pid)] = group_id
+		pid_hash[group_id] = (name, -1)
+		cur_group += 1
+
+while True:
+	fields = iowatcher.read_event()
+	if fields == ():
+		break
+	magic, sequence, time, sector, bytelen, action, pid, device, cpu, error, pdu_len, payload = fields;
+	if action == iowatcher.BLK_TN_PROCESS:
+		if not pid in group_hash:
+			# Trim to the first \0
+			payload = payload[0:payload.index('\0')]
+			payload += ' (' + str(pid) + ')'
+			pid_hash[pid] = (payload, -1)
+	elif action & iowatcher.BLK_TC_ACT(iowatcher.BLK_TC_NOTIFY):
+		iowatcher.write_response_end()
+		continue
+	elif (action & iowatcher.BLK_TA_MASK == iowatcher.__BLK_TA_QUEUE) or \
+	      (action & iowatcher.BLK_TA_MASK == iowatcher.__BLK_TA_ISSUE):
+		if pid in group_hash:
+			pid = group_hash[pid]
+		if pid in pid_hash:
+			comm, tag = pid_hash[pid]
+		else:
+			comm = '? (' + str(pid) + ')'
+			tag = -1
+		if tag == -1:
+			tag = cur_tag
+			cur_tag += 1
+			iowatcher.write_response_newtag(tag, comm)
+			pid_hash[pid] = (comm, tag)
+		iowatcher.write_response_iotag(tag)
+	iowatcher.write_response_end()
-- 
2.6.6
