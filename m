Return-Path: <natechancellor@gmail.com>
Return-Path: <natechancellor@gmail.com>
From: Nathan Chancellor <natechancellor@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH RESEND] drbd: avoid clang warning about pointless switch statement
Date: Tue,  2 Oct 2018 10:14:48 -0700
Message-Id: <20181002171447.10765-1-natechancellor@gmail.com>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

The drbd code causes warnings that we cannot easily disable when building with clang:

In file included from drivers/block/drbd/drbd_debugfs.c:10:
In file included from drivers/block/drbd/drbd_int.h:48:
In file included from include/linux/drbd_genl_api.h:53:
In file included from include/linux/genl_magic_struct.h:237:
include/linux/drbd_genl.h:300:1: warning: no case matching constant switch condition '0'

There is nothing wrong with the code, and adding 'default:' labels
in the right place is enough to let clang shut up about the warning.

Fixes: ec2c35ac1ea2 ("drbd: prepare the transition from connector to genetlink")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

This was recently resent by Philipp Klocke but the attribution on it
was incorrect (had Arnd's signoff but no From: line) and linux-block
wasn't cc'd, who presumably should take this patch since this file was
introduced by commit ec2c35ac1ea2 ("drbd: prepare the transition from
connector to genetlink"). If that is the case, perhaps these files
should be added to the drbd MAINTAINERS entry since they were introduced
by drbd and have been the only consumers since; I'd be happy to send a
patch if others agree.

It was acked by Lars on https://lore.kernel.org/patchwork/patch/756723/
so I don't know if this patch should carry

Acked-by: Lars Ellenberg <lars.ellenberg@linbit.com>

or not. I'll leave that up to the maintainer to decide.

Thanks!
Nathan

 include/linux/genl_magic_struct.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/genl_magic_struct.h b/include/linux/genl_magic_struct.h
index 5972e4969197..c11f42179c63 100644
--- a/include/linux/genl_magic_struct.h
+++ b/include/linux/genl_magic_struct.h
@@ -191,6 +191,7 @@ static inline void ct_assert_unique_operations(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	default:
 		;
 	}
 }
@@ -209,6 +210,7 @@ static inline void ct_assert_unique_top_level_attributes(void)
 {
 	switch (0) {
 #include GENL_MAGIC_INCLUDE_FILE
+	default:
 		;
 	}
 }
@@ -219,6 +221,7 @@ static inline void ct_assert_unique_ ## s_name ## _attributes(void)	\
 {									\
 	switch (0) {							\
 		s_fields						\
+		default:						\
 			;						\
 	}								\
 }
-- 
2.19.0
