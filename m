Received: from MSK-MAILEDGE.securitycode.ru (msk-mailedge.securitycode.ru [195.133.217.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E95338D;
	Mon,  7 Oct 2024 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.217.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310971; cv=none; b=OdpmkU1OG/k2+/FpxVVqzduFDGmTmwbsyGy9B0zw1Bmxv/j7y62+zYg2F36vc2New2/V/RM28qrSpBcw9Hc5jAW0QCPuTWeEFZU4d0m9S//Ncpco3ytiyAmwtM5s6/XVkIlYWbNJGouAWJuRKY7fcP7ECyVzjVDwztn6up/tx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310971; c=relaxed/simple;
	bh=4jhDfpfpgCyddwDBxOgIA7K7Kk5rU/bHljeRUpcpP4s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Up9UnKR2xWgA0B5dccrOtqptYQJG1v2Y2fZ6rr5MDesmyv1/8+62QaO9ANHpnrm2JW2bzZ56t1/hXeHf/0lXlQFfY25wX87GQZ3cqOBjgi7SoeiodvAOVwgB3RXwI+vSDDWWJ4yIbLl3FyFkljwym/4ncDG1nZUaWzpDHqXuWzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru; spf=pass smtp.mailfrom=securitycode.ru; arc=none smtp.client-ip=195.133.217.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=securitycode.ru
From: George Rurikov <g.ryurikov@securitycode.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: George Ryurikov <g.ryurikov@securitycode.ru>, Paolo Valente
	<paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Yu Kuai <yukuai3@huawei.com>, Jan Kara
	<jack@suse.cz>
Subject: [PATCH 5.10] block, bfq: remove useless checking in bfq_put_queue()
Date: Mon, 7 Oct 2024 17:07:08 +0300
Message-ID: <20241007140709.1762881-1-g.ryurikov@securitycode.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SPB-EX1.Securitycode.ru (172.16.24.91) To
 MSK-EX2.Securitycode.ru (172.17.8.92)

From: George Ryurikov <g.ryurikov@securitycode.ru>

From: Yu Kuai <yukuai3@huawei.com>

commit 1e3cc2125d7cc7d492b2e6e52d09c1e17ba573c3

'bfqq->bfqd' is ensured to set in bfq_init_queue(), and it will never
change afterwards.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220816015631.1323948-3-yukuai1@huaweiclou=
d.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: George Ryurikov <g.ryurikov@securitycode.ru>
---
 block/bfq-iosched.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6687b805bab3..0031c5751d89 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4864,9 +4864,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
        struct hlist_node *n;
        struct bfq_group *bfqg =3D bfqq_group(bfqq);

-       if (bfqq->bfqd)
-               bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d",
-                            bfqq, bfqq->ref);
+       bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d", bfqq, bfqq->ref)=
;

        bfqq->ref--;
        if (bfqq->ref)
@@ -4931,7 +4929,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
                hlist_del_init(&item->woken_list_node);
        }

-       if (bfqq->bfqd && bfqq->bfqd->last_completed_rq_bfqq =3D=3D bfqq)
+       if (bfqq->bfqd->last_completed_rq_bfqq =3D=3D bfqq)
                bfqq->bfqd->last_completed_rq_bfqq =3D NULL;

        kmem_cache_free(bfq_pool, bfqq);
--
2.34.1
=D0=97=D0=B0=D1=8F=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BE =D0=BA=D0=BE=
=D0=BD=D1=84=D0=B8=D0=B4=D0=B5=D0=BD=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=D0=
=BE=D1=81=D1=82=D0=B8

=D0=94=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=8D=D0=BB=D0=B5=D0=BA=D1=82=D1=80=
=D0=BE=D0=BD=D0=BD=D0=BE=D0=B5 =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=BE =D0=B8 =
=D0=BB=D1=8E=D0=B1=D1=8B=D0=B5 =D0=BF=D1=80=D0=B8=D0=BB=D0=BE=D0=B6=D0=B5=
=D0=BD=D0=B8=D1=8F =D0=BA =D0=BD=D0=B5=D0=BC=D1=83 =D1=8F=D0=B2=D0=BB=D1=8F=
=D1=8E=D1=82=D1=81=D1=8F =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B4=D0=B5=D0=BD=
=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=BC=D0=B8 =D0=B8 =D0=BF=D1=80=
=D0=B5=D0=B4=D0=BD=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D1=8B =D0=B8=
=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE =
=D0=B4=D0=BB=D1=8F =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D0=B0=D1=82=D0=B0. =D0=95=
=D1=81=D0=BB=D0=B8 =D0=92=D1=8B =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=
=D1=82=D0=B5=D1=81=D1=8C =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D0=B0=D1=82=D0=BE=
=D0=BC =D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=B8=D1=81=D1=8C=
=D0=BC=D0=B0, =D0=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0,=
 =D1=83=D0=B2=D0=B5=D0=B4=D0=BE=D0=BC=D0=B8=D1=82=D0=B5 =D0=BD=D0=B5=D0=BC=
=D0=B5=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE =D0=BE=D1=82=D0=BF=D1=80=D0=B0=
=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8F, =D0=BD=D0=B5 =D1=80=D0=B0=D1=81=D0=BA=
=D1=80=D1=8B=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=
=D0=B6=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B4=D1=80=D1=83=D0=B3=D0=B8=D0=BC =D0=BB=
=D0=B8=D1=86=D0=B0=D0=BC, =D0=BD=D0=B5 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D1=83=D0=B9=D1=82=D0=B5 =D0=B5=D0=B3=D0=BE =D0=B2 =D0=BA=D0=B0=D0=BA=
=D0=B8=D1=85-=D0=BB=D0=B8=D0=B1=D0=BE =D1=86=D0=B5=D0=BB=D1=8F=D1=85, =D0=
=BD=D0=B5 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8 =D0=BD=D0=B5 =
=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D1=83=D0=B9=D1=82=D0=B5 =D0=B8=D0=BD=D1=84=
=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BB=D1=8E=D0=B1=D1=8B=D0=BC =
=D1=81=D0=BF=D0=BE=D1=81=D0=BE=D0=B1=D0=BE=D0=BC.
