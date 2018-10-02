Return-Path: <natechancellor@gmail.com>
Return-Path: <natechancellor@gmail.com>
From: Nathan Chancellor <natechancellor@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH RESEND] drbd: Change drbd_request_detach_interruptible's return type to int
Date: Tue,  2 Oct 2018 10:12:49 -0700
Message-Id: <20181002171248.9853-1-natechancellor@gmail.com>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Clang warns when an implicit conversion is done between enumerated
types:

drivers/block/drbd/drbd_state.c:708:8: warning: implicit conversion from
enumeration type 'enum drbd_ret_code' to different enumeration type
'enum drbd_state_rv' [-Wenum-conversion]
                rv = ERR_INTR;
                   ~ ^~~~~~~~

drbd_request_detach_interruptible's only call site is in the return
statement of adm_detach, which returns an int. Change the return type of
drbd_request_detach_interruptible to match, silencing Clang's warning.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/block/drbd/drbd_state.c | 6 ++----
 drivers/block/drbd/drbd_state.h | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 0813c654c893..b452359b6aae 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -688,11 +688,9 @@ request_detach(struct drbd_device *device)
 			CS_VERBOSE | CS_ORDERED | CS_INHIBIT_MD_IO);
 }
 
-enum drbd_state_rv
-drbd_request_detach_interruptible(struct drbd_device *device)
+int drbd_request_detach_interruptible(struct drbd_device *device)
 {
-	enum drbd_state_rv rv;
-	int ret;
+	int ret, rv;
 
 	drbd_suspend_io(device); /* so no-one is stuck in drbd_al_begin_io */
 	wait_event_interruptible(device->state_wait,
diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index ea58301d0895..cff0a34c150b 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -162,8 +162,7 @@ static inline int drbd_request_state(struct drbd_device *device,
 }
 
 /* for use in adm_detach() (drbd_adm_detach(), drbd_adm_down()) */
-enum drbd_state_rv
-drbd_request_detach_interruptible(struct drbd_device *device);
+int drbd_request_detach_interruptible(struct drbd_device *device);
 
 enum drbd_role conn_highest_role(struct drbd_connection *connection);
 enum drbd_role conn_highest_peer(struct drbd_connection *connection);
-- 
2.19.0
