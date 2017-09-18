Return-Path: <SRS0=JZWyce=AT=moysys.com=michael@eigbox.net>
To: axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
From: Michael Moy <michael@moysys.com>
Subject: [PATCH v2] fs: pass the write life time hint to the mapped filesystem
Message-ID: <2f7829a5-d47b-e6a0-cc10-8b534e9772ab@moysys.com>
Date: Mon, 18 Sep 2017 09:45:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: Michael Moy <michael@moysys.com>
List-ID: <linux-block@vger.kernel.org>

The write hint needs to be copied to the mapped filesystem
so it can be passed down to the nvme device driver.

v2: fix tabs in the email

Signed-off-by: Michael Moy <michael.moy@encoresemi.com>
---
   mm/filemap.c | 10 ++++++++++
   1 file changed, 10 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 870971e..f9849b8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3008,6 +3008,16 @@ ssize_t generic_perform_write(struct file *file,
   			break;
   		}

+		/*
+		 * Copy a write hint to the mapped filesystem.
+		 *
+		 * Use the File hint first, inode next.
+		 */
+		if (file->f_write_hint)
+			mapping->host->i_write_hint = file->f_write_hint;
+		else if (file->f_inode->i_write_hint)
+			mapping->host->i_write_hint = file->f_inode->i_write_hint;
+
   		status = a_ops->write_begin(file, mapping, pos, bytes, flags,
   						&page, &fsdata);
   		if (unlikely(status < 0))
--
1.8.3.1
