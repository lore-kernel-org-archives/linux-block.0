Return-Path: <khlebnikov@yandex-team.ru>
Subject: [PATCH] block: add partition uuid into uevent as "PARTUUID"
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org
Date: Fri, 06 Oct 2017 14:42:16 +0300
Message-ID: <150729013610.744480.1644359289262914898.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

Both most common formats have uuid in addition to partition name:
GPT: standard uuid xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
DOS: 4 byte disk signature and 1 byte partition xxxxxxxx-xx

Tools from util-linux use the same notation for them.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 block/partition-generic.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 88c555db4e5d..8f8b580aee16 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -226,6 +226,8 @@ static int part_uevent(struct device *dev, struct kobj_uevent_env *env)
 	add_uevent_var(env, "PARTN=%u", part->partno);
 	if (part->info && part->info->volname[0])
 		add_uevent_var(env, "PARTNAME=%s", part->info->volname);
+	if (part->info && part->info->uuid[0])
+		add_uevent_var(env, "PARTUUID=%s", part->info->uuid);
 	return 0;
 }
 
