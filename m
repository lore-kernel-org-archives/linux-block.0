Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794367589;
	b=08348QKd3TviG4GSbQm7eDrbWIqEsPU7OtFCMSmpcZCtuP3VdQcOwKib9S1/KB3aNflj
	 ATjdEpeJ6ndxce4lHsdVQx99v5rXN9oKJZCO9HykvNETbWjDDinbVHrhjnh33pMHZoLLU
	 6lTpmQhjMPObIDeTmv1dGpdu3hGPlVBEmHqX+nWEBoI2dn87oowlF6Dq+X6g+0j83lnS/
	 2wJqNNsj3wTkQ/w+3rF/TsrvfRJGL2KVXnEWj++rCS66RLuUTZhAq0+QSYYA1lW6V0UUR
	 1bC8f07A89jHekOOR3laBg2HRAn1LWAbSR10MmrpkPfRtfdb6rzKiS/2G+lqwOY5SGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ap4cqG/NlhaBcpOxORsgSraKiaepD805iasuc2oGl0o=;
	b=ETPPp/OtHTmL2LWcX65W7UlgLQMgZyGAppWSRzp8Yukb24+PCcEyh+1v0DprDx9Ze0gX
	 whrgndILb4Yf8KUEhTP9PbOVK7TrTcBScxBnEJhEdEGgxk89HpObdpvJmeo3JzHDzIKeL
	 eoG/TSyFdxc2fpCRy3s8J/yk7hqizNQhY1bXCCXMwu1JiuWjmM0Uv9UbnzidBdhIP31CA
	 sRCuabtja/rBRu62qsbjA0WJHCnI6vdEVv3NN6HHIDVRVCrZdcEpFm1gZ+9TWhzvuHxca
	 o8KGsYVZsJYNpuSdV18divn1gs6Ba1uVioFC/UEb4rjiLL5a6Qt8J3Op46nu5BMCqDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RVaXykki;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25216606A320
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 03:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25216606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RVaXykki
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so1479334fac.3
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 19:26:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794367588; cv=none;
        d=google.com; s=arc-20260327;
        b=XU4UmoO3/MqIRa6shYChT77FqkmcNoSWdddIADXHqsDtDL9UeV/x4TLsO5cK1ORqz+
         GPPknFv2LtZB6fr+ly0z0wwzcpwu/lK69NSDZD3otr1tnC7rcdT5beKcnsU6AtZvv7gM
         +XuxbOvEzn+soEp3rfLfILAqLmzJTlnAHJwqdWl/Mr3BrURyan44L6Una/DYHHBcHKkk
         0g7MAtsGqDaZ+0eyDvrEauakVjkKqwatabRhN9OclZnDnih/vOn7G56kRgfzLPS0F00W
         6gHWiY5DIdRtOAQ5QGWnvx7phHU9JplrseEiwusXjjGxOV1FnyW2p6Nqc2mvFL1Ppzbm
         gUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ap4cqG/NlhaBcpOxORsgSraKiaepD805iasuc2oGl0o=;
        fh=2AIj4g4u/OyHkDbirr5Vwr/NY4LcISmxo04TyPjdDw4=;
        b=ZUzQwOekpnFUPmnBn8cGBnqR2QILI2cX36xttP962izWu7+oN0rLduSM4rEvmMWv2B
         NxvvYdVlrC/zsJT7n8Z2NNJqwvWkChpMUnE9VKdwnSAN/uds4IJAekovw0o3niacpurc
         8vwVzdKSihGOV5LRTJAId99bEOFLlyzZ+dJRtpf1zikfXSlTwmr4IGLnYj7VmQbWaWPz
         fTe45Xmx5MXNL7bcqNe2upfiXCjDueab8uTTnMCwX+0Gsl9YLa3BM6CvGug/AWIUNwts
         ahoGOknfYCxRfu3voIWUiEBGQAYauG7UJ8jp9bqCyFyDdKLuKujeSLJ+4MSxj/4TwGnF
         biTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794367588; x=1794972388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ap4cqG/NlhaBcpOxORsgSraKiaepD805iasuc2oGl0o=;
        b=RVaXykkiSSSAMExeP+SVx+eLRmxgK89uLqvgvzlzjoDlQhFBqoZdLOVYIvy87xKgSP
         s9rIugjeBBbkr9bH9mcGyU3mzqpwecMQJSvNV4pJFCb0zzFHHLRZbxgxKTXh2lXE2BTi
         EY9+GHN8Ak+SCZkfx1lP5LWqpnjiT80Aa/ws+QonBmd31DDvbIYukiOwjWGvgKQ8VYEw
         dKWlBmhE57OjgzRmbN2Hqc9jOpirywMrhPSPDIbQrSqkLAzQfGFCLUR+m9xo/KPKiPYD
         LS0Y4xSwWX3EktvJbxa4bY0sKzNnunR5Aalx09gaOVllYLnAbzPahsbDezqDReDdQlHk
         NpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367588; x=1794972388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ap4cqG/NlhaBcpOxORsgSraKiaepD805iasuc2oGl0o=;
        b=qNPBTxQ0X0bA8FQ8wkTqZWufVlJLBXylflEQMw+gfrW3wX/8GVHRTcUHgIKlESfxXV
         ygY5Zs2E1DboPsPAmHP7EoO1S+Qvvwpq7DNXmMx61mwgHdVRulFLOzrGCiQmpFvhzDUx
         52DpbsD2mPkUD945Trk7RBLa+PG18m+JJPp86b4NMgHOal6HqZqLvcEw2HLWWyQjXfF+
         i73bG4fef/7VhEneJ/tXXeJxKoPQOn2LO7ho7EMYY5Xof7ZJPBvRfcRESbAP2sEw59jO
         cKugyG8r1shDh/mLLhfcIfTmF0ke5CQy8+lrHk2zKt3Ikd+/vG137ZTuEZCrBBzM9Lac
         k3VA==
X-Gm-Message-State: APuU4Z821SL5rCFAdGPi6xXx3P+YqIFgevaN9WnI3fd6mhjinRmBI2AN
	QPyL2/ooWzn+ZBgPqhrr4Rw6W8FxtFQswakHdOVWljug0/rGOlZXLOAfCq9RMSeCdgtg9/plNGR
	d0CgulrWye5HAaP1NNWFSALSCh5Jy5hQ=
X-Gm-Gg: AYBFou07ZzgT2Fl/1Z8J8waopvr9AZNHUNgGRSEtiXSIETX/EneM5vP5Nztu1W0VEO/
	zwgc3W4wdpwDjIGOGc6fPwTqvHsm7J+yT5LnHx4KTv3RRdUnhsumraAxRVjRn2JmcI9AX8eZxTB
	+Kx4Oix0oPuiqQNACsJffPNN7KduvMTiK0cNGlhNMpJLnPqm02jsimkbp/iOgGkmjx+jPnf3IFX
	ZzRmQPeVMSQAU/RokanRRQJ63oAJcsj2Cq7UJl7zodOcsH3tZwCo9kbgcEMANt4og+KDsoSQ+zH
	sRO2O0HwVh5K8WdTqabGZyqaCBmILyQwWinipi1njFyKR4sToc/Z51n8LLHDp/Vh1CjwL2nj/sE
	VX7exkLkBjfZdTZQUQhEmhRadLqJWsssTbd3mYRNg3c8JF52WrYmF7aSNRZVU3yn01aiXSFm6PZ
	THu8Bfrl62tHIeaXta/sg/dh6QnHLSJLsLuUj6cA==
X-Received: by 2002:a05:6870:1b0c:b0:49d:c3f6:4191 with SMTP id
 586e51a60fabf-4ae46b7ad9dmr1244368fac.18.1794367587733; Tue, 10 Nov 2026
 19:26:27 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111111455541qAdd9RB0rUfpsuO-qYSne@zte.com.cn>
In-Reply-To: <20261111111455541qAdd9RB0rUfpsuO-qYSne@zte.com.cn>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 10 Nov 2026 21:26:16 -0600
X-Gm-Features: AclHuK8mU4knlc3plyz22hZSYsu_-l0cLAdxqzPq_sYq1-iZJfcdOG-JJduA6g8
Message-ID: <CACVXFVMgLsPgGV=bVgnKY0h14RY=P9Q5j_+14ZKfg1xjLowVDA@mail.gmail.com>
Subject: Re: [PATCH v2] ublk: stop reporting zones on an empty response
To: shao.mingyin@zte.com.cn
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:15=E2=80=AFPM <shao.mingyin@zte.com.cn> wrote:
>
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> ublk_report_zones() treats a zero-length zone as the end of the current
> server response and keeps asking for the remaining zones from the sector
> after the last reported one.  A response that carries no zone at all
> therefore advances neither done_zones nor sector, and the driver issues
> REPORT ZONES requests for the same sector forever.  Both BLKREPORTZONE
> and the zone revalidation done when the device starts hang, and the task
> cannot be killed.
>
> Only a response with no zone cannot make progress.  Terminate the whole
> report in that case, and keep following up on a short but non-empty
> response as before, which is what sd_zbc and virtio_blk do.
>
> Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
> Suggested-by: Ming Lei <tom.leiming@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> v2:
> - Stop only when a response carries no zone at all, so that a short but
>   non-empty response is still followed up from the advanced sector.
>   The v1 form ended the whole report at the first zero-length zone and
>   truncated such reports (reported by Ming Lei).
> v1: https://lore.kernel.org/all/20261109225110056QQJAEflTHzwYHzwXlMBb_@zt=
e.com.cn/
>
>  drivers/block/ublk_drv.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -661,6 +661,7 @@ static int ublk_report_zones(struct gendisk *disk, se=
ctor_t sector,
>                 struct request *req;
>                 struct ublk_zoned_report_desc desc;
>                 blk_status_t status;
> +               unsigned int i;
>
>                 memset(buffer, 0, buffer_length);
>
> @@ -689,7 +690,7 @@ static int ublk_report_zones(struct gendisk *disk, se=
ctor_t sector,
>                 if (ret)
>                         goto out;
>
> -               for (unsigned int i =3D 0; i < zones_in_request; i++) {
> +               for (i =3D 0; i < zones_in_request; i++) {
>                         struct blk_zone *zone =3D buffer + i;
>
>                         /* A zero length zone means no more zones in this=
 response */
> @@ -704,6 +705,10 @@ static int ublk_report_zones(struct gendisk *disk, s=
ector_t sector,
>                         sector +=3D zone_size_sectors;
>
>                 }
> +
> +               /* An empty response cannot make progress, stop asking. *=
/
> +               if (!i)
> +                       break;
>         }

Looks fine, and verified with one ublk zoned server which returns
empty or short report: BLKREPORTZONE & START_DEV don't hang any more
on empty response, and all zones are still reported on short response.

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming Lei
