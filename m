Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59818 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933816AbeFVWTt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 18:19:49 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests 04/15] Suppress shellcheck complaints about global variables
Date: Fri, 22 Jun 2018 15:19:35 -0700
Message-Id: <20180622221946.10987-5-bart.vanassche@wdc.com>
In-Reply-To: <20180622221946.10987-1-bart.vanassche@wdc.com>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add a new file common/shellcheck and include it in all test scripts
that use global variables. The file common/shellcheck contains a
statement that stops shellcheck to complain about global variables:

echo "$CHECK_DMESG ${CPUS_ONLINE_SAVED[*]} $DESCRIPTION $DMESG_FILTER $FIO_PERF_FIELDS $FIO_PERF_PREFIX $RESTORE_CPUS_ONLINE $QUICK $SKIP_REASON ${TEST_RUN[*]} $TIMED" >/dev/null

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 common/cpuhotplug | 2 ++
 common/fio        | 2 ++
 common/iopoll     | 2 ++
 common/loop       | 1 +
 common/nbd        | 2 ++
 common/nvme       | 2 ++
 common/scsi       | 2 ++
 common/shellcheck | 4 ++++
 new               | 2 ++
 tests/block/001   | 1 +
 tests/block/002   | 1 +
 tests/block/003   | 2 ++
 tests/block/004   | 2 ++
 tests/block/005   | 2 ++
 tests/block/006   | 2 ++
 tests/block/007   | 1 +
 tests/block/009   | 1 +
 tests/block/010   | 2 ++
 tests/block/011   | 2 ++
 tests/block/012   | 2 ++
 tests/block/013   | 2 ++
 tests/block/014   | 2 ++
 tests/block/015   | 2 ++
 tests/block/016   | 2 ++
 tests/block/017   | 2 ++
 tests/block/018   | 2 ++
 tests/block/019   | 2 ++
 tests/block/020   | 2 ++
 tests/block/021   | 2 ++
 tests/loop/001    | 2 ++
 tests/loop/003    | 2 ++
 tests/loop/005    | 2 ++
 tests/meta/001    | 2 ++
 tests/meta/002    | 2 ++
 tests/meta/003    | 2 ++
 tests/meta/004    | 2 ++
 tests/meta/005    | 2 ++
 tests/meta/006    | 2 ++
 tests/meta/007    | 2 ++
 tests/meta/008    | 2 ++
 tests/meta/009    | 2 ++
 tests/meta/010    | 2 ++
 tests/meta/011    | 2 ++
 tests/meta/012    | 2 ++
 tests/nbd/001     | 2 ++
 tests/nbd/002     | 2 ++
 tests/nvme/001    | 2 ++
 tests/nvme/002    | 2 ++
 tests/nvme/003    | 2 ++
 tests/nvme/004    | 2 ++
 tests/nvme/005    | 2 ++
 tests/nvme/006    | 2 ++
 tests/nvme/007    | 2 ++
 tests/nvme/008    | 2 ++
 tests/nvme/009    | 2 ++
 tests/nvme/010    | 2 ++
 tests/nvme/011    | 2 ++
 tests/nvme/012    | 2 ++
 tests/nvme/013    | 2 ++
 tests/scsi/001    | 2 ++
 tests/scsi/002    | 2 ++
 tests/scsi/003    | 2 ++
 tests/scsi/004    | 1 +
 63 files changed, 122 insertions(+)
 create mode 100644 common/shellcheck

diff --git a/common/cpuhotplug b/common/cpuhotplug
index 70b284f7b7aa..9f43615a8f64 100644
--- a/common/cpuhotplug
+++ b/common/cpuhotplug
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 # Also initializes the ALL_CPUS and HOTPLUGGABLE_CPUS arrays.
 _have_cpu_hotplug() {
 	ALL_CPUS=()
diff --git a/common/fio b/common/fio
index 0f93632c0382..949796810a0c 100644
--- a/common/fio
+++ b/common/fio
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 _have_fio() {
 	if ! _have_program fio; then
 		return 1
diff --git a/common/iopoll b/common/iopoll
index affdd4332dc2..10ebd16923ad 100644
--- a/common/iopoll
+++ b/common/iopoll
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 _have_fio_with_poll() {
 	if ! _have_fio; then
 		return 1
diff --git a/common/loop b/common/loop
index 16cc3212a028..28071840ed9b 100644
--- a/common/loop
+++ b/common/loop
@@ -17,6 +17,7 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
 
 _have_loop_set_block_size() {
 	src/loblksize "$(losetup -f)" 512 &>/dev/null
diff --git a/common/nbd b/common/nbd
index 320f456e0bd8..2e0186482989 100644
--- a/common/nbd
+++ b/common/nbd
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 _have_nbd() {
 	if ! _have_module nbd; then
 		return 1
diff --git a/common/nvme b/common/nvme
index 044d7fe94c65..0060f3e29573 100644
--- a/common/nvme
+++ b/common/nvme
@@ -19,6 +19,8 @@
 
 NVMET_CFS="/sys/kernel/config/nvmet/"
 
+. common/shellcheck
+
 _test_dev_is_nvme() {
 	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
 		SKIP_REASON="$TEST_DEV is not a NVMe device"
diff --git a/common/scsi b/common/scsi
index d9fcc0e15909..eb5a3ddc708f 100644
--- a/common/scsi
+++ b/common/scsi
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 _have_scsi_generic() {
 	_have_module sg
 }
diff --git a/common/shellcheck b/common/shellcheck
new file mode 100644
index 000000000000..1ec759976dd7
--- /dev/null
+++ b/common/shellcheck
@@ -0,0 +1,4 @@
+#!/bin/bash
+
+# Suppress shellcheck complaints about global variables used in test scripts.
+echo "$CHECK_DMESG ${CPUS_ONLINE_SAVED[*]} $DESCRIPTION $DMESG_FILTER $FIO_PERF_FIELDS $FIO_PERF_PREFIX $RESTORE_CPUS_ONLINE $QUICK $SKIP_REASON ${TEST_RUN[*]} $TIMED" >/dev/null
diff --git a/new b/new
index 923d6b737986..334092498c52 100755
--- a/new
+++ b/new
@@ -159,6 +159,8 @@ cat << EOF > "tests/${test_name}"
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 # TODO: fill in a very brief description of what this test does. The
 # description should complete the sentence "This test will...". For example,
 # "run a mixed read/write workload" would be a good description.
diff --git a/tests/block/001 b/tests/block/001
index 7411a0cf04f6..8016265d11e3 100755
--- a/tests/block/001
+++ b/tests/block/001
@@ -20,6 +20,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 . common/scsi_debug
+. common/shellcheck
 
 DESCRIPTION="stress device hotplugging"
 TIMED=1
diff --git a/tests/block/002 b/tests/block/002
index 57b4f8984095..32a0f818b95b 100755
--- a/tests/block/002
+++ b/tests/block/002
@@ -19,6 +19,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 . common/scsi_debug
+. common/shellcheck
 
 DESCRIPTION="remove a device while running blktrace"
 QUICK=1
diff --git a/tests/block/003 b/tests/block/003
index 87e30a36e8c2..e73e4fc60fbe 100755
--- a/tests/block/003
+++ b/tests/block/003
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="run various discard sizes"
 TIMED=1
 
diff --git a/tests/block/004 b/tests/block/004
index 754d30260d63..59e157b1c337 100755
--- a/tests/block/004
+++ b/tests/block/004
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="run lots of flushes"
 TIMED=1
 
diff --git a/tests/block/005 b/tests/block/005
index fae59272f90b..2e6dd38cc931 100755
--- a/tests/block/005
+++ b/tests/block/005
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="switch schedulers while doing IO"
 TIMED=1
 
diff --git a/tests/block/006 b/tests/block/006
index 0a472935a481..be4b6c7560b3 100755
--- a/tests/block/006
+++ b/tests/block/006
@@ -20,6 +20,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="run null-blk in blocking mode"
 TIMED=1
 
diff --git a/tests/block/007 b/tests/block/007
index e35649ad96cd..15709fffd4fd 100755
--- a/tests/block/007
+++ b/tests/block/007
@@ -18,6 +18,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 . common/iopoll
+. common/shellcheck
 
 DESCRIPTION="test classic and hybrid IO polling"
 TIMED=1
diff --git a/tests/block/009 b/tests/block/009
index cbeeb70701fa..7d6afe9694eb 100755
--- a/tests/block/009
+++ b/tests/block/009
@@ -22,6 +22,7 @@
 DESCRIPTION="check page-cache coherency after BLKDISCARD"
 
 . common/scsi_debug
+. common/shellcheck
 
 requires() {
 	_have_scsi_debug && _have_program xfs_io
diff --git a/tests/block/010 b/tests/block/010
index 97891d229c0f..bbe714101aee 100644
--- a/tests/block/010
+++ b/tests/block/010
@@ -20,6 +20,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="run I/O on null_blk with shared and non-shared tags"
 TIMED=1
 
diff --git a/tests/block/011 b/tests/block/011
index 24614420461e..ab02f90f2069 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="disable PCI device while doing I/O"
 TIMED=1
 
diff --git a/tests/block/012 b/tests/block/012
index baabdd68b655..2c1b761ba063 100755
--- a/tests/block/012
+++ b/tests/block/012
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="check that a read-only block device fails writes"
 TIMED=1
 
diff --git a/tests/block/013 b/tests/block/013
index 415b34dcc5ef..8f386313cd2b 100755
--- a/tests/block/013
+++ b/tests/block/013
@@ -23,6 +23,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="try BLKRRPART on a mounted device"
 QUICK=1
 
diff --git a/tests/block/014 b/tests/block/014
index 882a9b9f5015..f5503ee9683c 100755
--- a/tests/block/014
+++ b/tests/block/014
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="run null-blk with timeout injection configured"
 
 requires() {
diff --git a/tests/block/015 b/tests/block/015
index b236a6d36bf8..0c9daa6be13e 100755
--- a/tests/block/015
+++ b/tests/block/015
@@ -18,6 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="run null-blk on different schedulers with requeue injection configured"
 
 QUICK=1
diff --git a/tests/block/016 b/tests/block/016
index 6ccfe98f54ce..5a1ff33c34fb 100755
--- a/tests/block/016
+++ b/tests/block/016
@@ -19,6 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="send a signal to a process waiting on a frozen queue"
 QUICK=1
 
diff --git a/tests/block/017 b/tests/block/017
index 436a8f336155..e9ca282750ba 100755
--- a/tests/block/017
+++ b/tests/block/017
@@ -19,6 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="do I/O and check the inflight counter"
 QUICK=1
 
diff --git a/tests/block/018 b/tests/block/018
index 548f1baeaf59..21421b869c18 100755
--- a/tests/block/018
+++ b/tests/block/018
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="do I/O and check iostats times"
 QUICK=1
 
diff --git a/tests/block/019 b/tests/block/019
index 00830d02b67a..f099d9392688 100755
--- a/tests/block/019
+++ b/tests/block/019
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="break PCI link device while doing I/O"
 QUICK=1
 
diff --git a/tests/block/020 b/tests/block/020
index 36140136369b..7db1b5a0d422 100755
--- a/tests/block/020
+++ b/tests/block/020
@@ -19,6 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="run null-blk on different schedulers with only one hardware tag"
 QUICK=1
 
diff --git a/tests/block/021 b/tests/block/021
index 74fa709a8e04..df5dc9b101ba 100755
--- a/tests/block/021
+++ b/tests/block/021
@@ -19,6 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="read/write nr_requests on null-blk with different schedulers"
 QUICK=1
 
diff --git a/tests/loop/001 b/tests/loop/001
index 1f009bdd1439..83103dc5e9c9 100755
--- a/tests/loop/001
+++ b/tests/loop/001
@@ -18,6 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="scan loop device partitions"
 QUICK=1
 
diff --git a/tests/loop/003 b/tests/loop/003
index fe4e2e1ed19b..353d4fcfa33c 100755
--- a/tests/loop/003
+++ b/tests/loop/003
@@ -18,6 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="time opening and closing an unbound loop device"
 QUICK=1
 
diff --git a/tests/loop/005 b/tests/loop/005
index b57ddb3d6f1a..d00f4bd06f73 100755
--- a/tests/loop/005
+++ b/tests/loop/005
@@ -19,6 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="call LOOP_GET_STATUS{,64} with a NULL arg"
 
 QUICK=1
diff --git a/tests/meta/001 b/tests/meta/001
index 454fb22554a3..d5b8c0665f7b 100755
--- a/tests/meta/001
+++ b/tests/meta/001
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="do nothing"
 
 test() {
diff --git a/tests/meta/002 b/tests/meta/002
index 5a2cd53f2318..50cdd5a3487c 100755
--- a/tests/meta/002
+++ b/tests/meta/002
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="do nothing"
 
 test_device() {
diff --git a/tests/meta/003 b/tests/meta/003
index eb79bca15ffb..e07e01efd697 100755
--- a/tests/meta/003
+++ b/tests/meta/003
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="exit with non-zero status"
 
 test() {
diff --git a/tests/meta/004 b/tests/meta/004
index bafe6c5e8da8..37d0e4649d56 100755
--- a/tests/meta/004
+++ b/tests/meta/004
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="exit with non-zero status"
 
 test_device() {
diff --git a/tests/meta/005 b/tests/meta/005
index c9909c64c022..1a4018af2d21 100755
--- a/tests/meta/005
+++ b/tests/meta/005
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="produce bad output"
 
 test() {
diff --git a/tests/meta/006 b/tests/meta/006
index 9d28bdce01d8..4d0786177555 100755
--- a/tests/meta/006
+++ b/tests/meta/006
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="produce lots of bad output"
 
 test() {
diff --git a/tests/meta/007 b/tests/meta/007
index 2516796a333d..13acfdb8ef42 100755
--- a/tests/meta/007
+++ b/tests/meta/007
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="skip in requires()"
 
 requires() {
diff --git a/tests/meta/008 b/tests/meta/008
index 5d24669b290e..acea355c4d91 100755
--- a/tests/meta/008
+++ b/tests/meta/008
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="skip in device_requires()"
 
 device_requires() {
diff --git a/tests/meta/009 b/tests/meta/009
index abeb56e6ad4f..989ce8ccf053 100755
--- a/tests/meta/009
+++ b/tests/meta/009
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="check dmesg"
 
 requires() {
diff --git a/tests/meta/010 b/tests/meta/010
index c179dad3d7c7..1e7e9da7d3fa 100755
--- a/tests/meta/010
+++ b/tests/meta/010
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="disable check dmesg"
 CHECK_DMESG=0
 
diff --git a/tests/meta/011 b/tests/meta/011
index 010ba4b142b8..df1f7e584622 100755
--- a/tests/meta/011
+++ b/tests/meta/011
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="filter dmesg"
 DMESG_FILTER="grep -v BUG"
 
diff --git a/tests/meta/012 b/tests/meta/012
index ab8c2a73eaa5..ecc1db296f32 100755
--- a/tests/meta/012
+++ b/tests/meta/012
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="record pid and random junk"
 
 test() {
diff --git a/tests/nbd/001 b/tests/nbd/001
index 73ccaec1305a..cee62412599a 100644
--- a/tests/nbd/001
+++ b/tests/nbd/001
@@ -18,6 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="resize a connected nbd device"
 QUICK=1
 
diff --git a/tests/nbd/002 b/tests/nbd/002
index c06c94631aab..6d6b3cddf1c6 100644
--- a/tests/nbd/002
+++ b/tests/nbd/002
@@ -24,6 +24,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="tests on partition handling for an nbd device"
 QUICK=1
 
diff --git a/tests/nvme/001 b/tests/nvme/001
index 0b5f241efcce..ada60f3b2270 100755
--- a/tests/nvme/001
+++ b/tests/nvme/001
@@ -18,6 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="enable nvme_setup_nvm_cmd tracepoint and submit I/O to the device"
 
 QUICK=1
diff --git a/tests/nvme/002 b/tests/nvme/002
index 786505e22256..59474f7d7574 100755
--- a/tests/nvme/002
+++ b/tests/nvme/002
@@ -18,6 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="create many subsystems and test discovery"
 
 requires() {
diff --git a/tests/nvme/003 b/tests/nvme/003
index 96341309baf6..9b168cb48278 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -18,6 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="test if we're sending keep-alives to a discovery controller"
 
 QUICK=1
diff --git a/tests/nvme/004 b/tests/nvme/004
index ad268e2eec83..9d087266bfa1 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -19,6 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="test nvme and nvmet UUID NS descriptors"
 QUICK=1
 
diff --git a/tests/nvme/005 b/tests/nvme/005
index f993019aa1d4..5c582bc38707 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -18,6 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="reset local loopback target"
 
 QUICK=1
diff --git a/tests/nvme/006 b/tests/nvme/006
index ecf0c334ae8b..ebdd50f61ff3 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -20,6 +20,8 @@
 #   Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
 #
 
+. common/shellcheck
+
 DESCRIPTION="create an NVMeOF target with a block device-backed ns"
 QUICK=1
 
diff --git a/tests/nvme/007 b/tests/nvme/007
index 02633131b868..138bfead51bb 100755
--- a/tests/nvme/007
+++ b/tests/nvme/007
@@ -20,6 +20,8 @@
 #   Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
 #
 
+. common/shellcheck
+
 DESCRIPTION="create an NVMeOF target with a file-backed ns"
 QUICK=1
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index dd62b25c5335..3b69809bb8fa 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -20,6 +20,8 @@
 #   Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
 #
 
+. common/shellcheck
+
 DESCRIPTION="create an NVMeOF host with a block device-backed ns"
 QUICK=1
 
diff --git a/tests/nvme/009 b/tests/nvme/009
index 0372788fef39..311e8171ca70 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -20,6 +20,8 @@
 #   Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
 #
 
+. common/shellcheck
+
 DESCRIPTION="create an NVMeOF host with a file-backed ns"
 QUICK=1
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index 9b31167c4988..956c6597a374 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -20,6 +20,8 @@
 #   Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
 #
 
+. common/shellcheck
+
 DESCRIPTION="run data verification fio job on NVMeOF block device-backed ns"
 TIMED=1
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index 6cd20fa26855..872a99af4f8c 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -20,6 +20,8 @@
 #   Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
 #
 
+. common/shellcheck
+
 DESCRIPTION="run data verification fio job on NVMeOF file-backed ns"
 TIMED=1
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index 255101101a18..8f632b30734d 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -20,6 +20,8 @@
 #   Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
 #
 
+. common/shellcheck
+
 DESCRIPTION="run mkfs and data verification fio job on NVMeOF block device-backed ns"
 TIMED=1
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 4bb49fa8f966..0ccb083b175b 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -20,6 +20,8 @@
 #   Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
 #
 
+. common/shellcheck
+
 DESCRIPTION="run mkfs and data verification fio job on NVMeOF file-backed ns"
 TIMED=1
 
diff --git a/tests/scsi/001 b/tests/scsi/001
index 17fc0880e654..08ad78489e0f 100755
--- a/tests/scsi/001
+++ b/tests/scsi/001
@@ -18,6 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="try triggering a kernel GPF with 0 byte SG reads"
 QUICK=1
 
diff --git a/tests/scsi/002 b/tests/scsi/002
index da2d0cc77aa0..ce037f0bbe79 100755
--- a/tests/scsi/002
+++ b/tests/scsi/002
@@ -18,6 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="perfom a SG_DXFER_FROM_DEV from the /dev/sg read-write interface"
 QUICK=1
 
diff --git a/tests/scsi/003 b/tests/scsi/003
index 81015f02f6b3..8c08cbdfe6a5 100755
--- a/tests/scsi/003
+++ b/tests/scsi/003
@@ -18,6 +18,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 DESCRIPTION="ensure re-reading the partition table keeps its read-only flag"
 QUICK=1
 
diff --git a/tests/scsi/004 b/tests/scsi/004
index 8c61d1e438f3..8bebb18d2554 100755
--- a/tests/scsi/004
+++ b/tests/scsi/004
@@ -26,6 +26,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 . common/scsi_debug
+. common/shellcheck
 
 DESCRIPTION="ensure repeated TASK SET FULL results in EIO on timing out command"
 
-- 
2.17.1
