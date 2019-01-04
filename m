Return-Path: <SRS0=wxXg=PM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D106C43387
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 14:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0DA208E3
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 14:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfADOZf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 09:25:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:32991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfADOZf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Jan 2019 09:25:35 -0500
Received: from localhost.localdomain ([113.116.156.175]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MexFh-1gytCX2sIr-00OV4Z; Fri, 04 Jan 2019 15:25:33 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: return NULL if request_module() failed in elevator_get()
Date:   Fri,  4 Jan 2019 22:25:20 +0800
Message-Id: <20190104142520.24699-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:CtjiCsouY5bFNsYi02XdODF4BA9b8XxNCoXVZiHkJBNGLwF/KMb
 oClcnChm5lerKx7VOzZcRFL7NZ6qeTrio/Gm3A6qBp3/oAd4Rk/L4GMVh/9/6nLMRsHHG76
 4E/keVop1W5Ltl/vx4ttXSB5nI6k5j1wqmjadFxYJlUgl+BcgdpfpLy7Icw0OU7XJuWvcch
 +QX4PmMDG/R2YSZIic9mA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NdpNDjiEtbk=:S6tfHtQh7N21FYVjBRvGuE
 UaMJYnrFZQnPtEaSQJrgjte+la6B6fC3WNLRvjts4K/CLyg18nIRB6WboXoX0LCs8zO4SyclP
 5KpnEdhUI3cUY8d89exYEHeGZw7B5oqLeImeBjAaI++heBb9GolVRYCM5Rw5gT2rRnp06yHWR
 kWFZL5H6lsVtTh4ua1g2m9Q0tk3eTC9VaiXTbBrazB2ky4YwFtHfb4ID+LpuvAGOrHKlCSJ6O
 xZmoFyquHeyyMxMhXXG10sJipzGZmNM4DkbIpWVGcnbONqSJw38Z+ZikfX+/LfbcHo9JicOjj
 sqtpdh6ZE3E8dktOZouPqhENXK40AVQ1O0mPXNI2Rw09BKfhA/rup6+sFXzJBSVkefTOWTt0/
 Sq3sPXAHJU2yCqdqsjNfrT/kfbL+0PLWP7VVte5omEZ5tHQ07xi+58d2eOmWMsVindqYZqg0N
 Hxj5rVk5PvysIRwGDPZ1u27YQAiLfxiK7RDev7oo7UE49y5YGJ6AUqPfxI7Oh4mCQkrw+SUuB
 F/UbeU4GnIzzki85iGFdtU42n+E8+qJEs9QzI2WOBKqDGBOzmebGi2FQ6loMMar+OnSNTzcj+
 OyDEoS223Yfkx06tnWIsOS83UMSGbfmCS9brN6JqTM8sjBXQS5fxnxLie0XMUkF2V11FBDZ+G
 QlJlUWYfC8z9jmasKYAbbMJrHltUIeQe+0ObIYJ9vUGI+c6aT/EHkBWpsJVBCBWVbsbBY3zX/
 GA4OfeNSEWMl4rtsSsD9ZGxaeO7MnIAK1b9yJyofKpqRZU0GDbeFjIh/SZViR5x3LhH/r7ZCr
 GDT1xm3+Nv4tA9Q2mg1RAf8bfJA+PF7T9mJQKBbQohSN1hMaEzt9UJKUc63+ipGuSANiyB4SF
 RnQpvYsTHbIxP3TvsT0DQ/CSQJezTOCcvzVW+wR8w=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If request_module() failed then it seems no reason to lookup
the iosched again, so add a check to handle this case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/elevator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 8fdcd64ae12e..f89527951243 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -124,7 +124,9 @@ static struct elevator_type *elevator_get(struct request_queue *q,
 	e = elevator_find(name, q->mq_ops != NULL);
 	if (!e && try_loading) {
 		spin_unlock(&elv_list_lock);
-		request_module("%s-iosched", name);
+		if (request_module("%s-iosched", name))
+			return e;
+
 		spin_lock(&elv_list_lock);
 		e = elevator_find(name, q->mq_ops != NULL);
 	}
-- 
2.17.2

