Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26982 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933858AbeFVWTv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 18:19:51 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests 10/15] tests/meta/group: Fix shellcheck complaints
Date: Fri, 22 Jun 2018 15:19:41 -0700
Message-Id: <20180622221946.10987-11-bart.vanassche@wdc.com>
In-Reply-To: <20180622221946.10987-1-bart.vanassche@wdc.com>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Avoid that shellcheck complains about unused global variables.
Avoid that shellcheck complains about using cat instead of
redirection.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 tests/meta/group | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/meta/group b/tests/meta/group
index 4281ea175a78..bae91281c493 100644
--- a/tests/meta/group
+++ b/tests/meta/group
@@ -17,6 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+. common/shellcheck
+
 group_requires() {
 	if [[ -v META_REQUIRES_SKIP ]]; then
 		SKIP_REASON="META_REQUIRES_SKIP was set"
@@ -76,7 +78,7 @@ RIP: blk_dev_init+0x4/0x6 RSP: ffffc9000031fe70
 ---[ end trace d9ab35f734a89f58 ]---
 EOF
 
-	cat "$TMPDIR/dmesg" | while IFS= read -r line; do
+	while IFS= read -r line; do
 		echo "$line" >> /dev/kmsg
-	done
+	done < "$TMPDIR/dmesg"
 }
-- 
2.17.1
