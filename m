Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704BBC433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Dec 2021 18:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245628AbhLJS4K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Dec 2021 13:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245629AbhLJS4J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Dec 2021 13:56:09 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64A7C0617A1
        for <linux-block@vger.kernel.org>; Fri, 10 Dec 2021 10:52:33 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id q17so6831646plr.11
        for <linux-block@vger.kernel.org>; Fri, 10 Dec 2021 10:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sck6On44bpX/LHpA1vcA3zK4iwtpxs9f24kXBzByf1o=;
        b=WMf0AKhxR2TjGl/HIlKI7tBoXOWw5s9MMtg4AZbG8Spgkc9etTpBwL4V8flW3R/sXT
         RsuK5JAgFrTsgpt9xIPimbQAK4QE8uqD9d/q0fags8/3w01g0MLFNtwi4LwrTFL5Yr7E
         7T+OjN1tWRRnSnpOb6mH4dD/eWfFfmhnsUulIWbOUlcmseb8LttUytsd6JX1LARZZ3dI
         jBRe+yLd9b9v9KvrX4JsKbFi9lATCITydW+fxvUlHLJZDX+yxfxN5f423J0K9i2Obw7W
         aqwKGYFzRKjMcMwZH/FpD3Zqdmhb/9KH9sM88o6AhqoNH2cYSS/c/TtzHsTua5wmX4B3
         Am+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sck6On44bpX/LHpA1vcA3zK4iwtpxs9f24kXBzByf1o=;
        b=EukqV5N9Ic6eJvuVB3IpomgfaHszAANAMEpXg+43sLz23YwWiKY5uZC6pCjU3odCAf
         Bsv+gNmHMPshNRsWWpMYvsK5/1s96+o301blPKlVjPKeKKW9c1X37rsyL1K3rechOpWB
         OU5l4lRzbvb7Fc2vnKBcNRcGNuC1Ys122c1k8lPlmu+VvtUn/vdKriI9flupANPIakvb
         A4r84mcCLnVnI9ehcvwAu6lqADbTMpeUyQKUm8xccP2yz+zHfi9siIFkl43ZLcm0sB2A
         8aH5yewyWcdjtmWA9i2/pAm8DiSKkXY1uZ3QSrNH/CgGjobPPiO3Tv3JWAI9EsPg95vD
         BoTw==
X-Gm-Message-State: AOAM533t1DobTuBns4e8ihNdQZVWJSiXgjj8OAngw8NsW+9/MBPlbzOV
        ywkGEbJwyJYggl6lij5rmDZUBA==
X-Google-Smtp-Source: ABdhPJw3vhyVAPk6E3z9227z4OJOYgXaX09wd1vyG5fgOYnMhoE6rntg8adUIwcnWyfvGwedp7QaNQ==
X-Received: by 2002:a17:902:d395:b0:141:a913:1920 with SMTP id e21-20020a170902d39500b00141a9131920mr77793133pld.81.1639162348388;
        Fri, 10 Dec 2021 10:52:28 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id p8sm4376422pfo.141.2021.12.10.10.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 10:52:28 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mtd_blkdevs: don't scan partitions for plain mtdblock
To:     Christoph Hellwig <hch@lst.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20211206070409.2836165-1-hch@lst.de>
Message-ID: <4bc1b80c-9c43-ccd6-de78-09f9a1627cc8@kernel.dk>
Date:   Fri, 10 Dec 2021 11:52:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211206070409.2836165-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 6, 2021 at 12:04 AM Christoph Hellwig <hch@lst.de> wrote:
>
> mtdblock / mtdblock_ro set part_bits to 0 and thus nevever scanned
> partitions.  Restore that behavior by setting the GENHD_FL_NO_PART flag.
>
> Fixes: 1ebe2e5f9d68e94c ("block: remove GENHD_FL_EXT_DEVT")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/mtd/mtd_blkdevs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index 113f86df76038..243f28a3206b4 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -346,7 +346,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>         gd->minors = 1 << tr->part_bits;
>         gd->fops = &mtd_block_ops;
>
> -       if (tr->part_bits)
> +       if (tr->part_bits) {
>                 if (new->devnum < 26)
>                         snprintf(gd->disk_name, sizeof(gd->disk_name),
>                                  "%s%c", tr->name, 'a' + new->devnum);
> @@ -355,9 +355,11 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>                                  "%s%c%c", tr->name,
>                                  'a' - 1 + new->devnum / 26,
>                                  'a' + new->devnum % 26);
> -       else
> +       } else {
>                 snprintf(gd->disk_name, sizeof(gd->disk_name),
>                          "%s%d", tr->name, new->devnum);
> +               gd->flags |= GENHD_FL_NO_PART;
> +       }

Not sure why I didn't spot this until now, but:

drivers/mtd/mtd_blkdevs.c: In function ‘add_mtd_blktrans_dev’:
drivers/mtd/mtd_blkdevs.c:362:30: error: ‘GENHD_FL_NO_PART’ undeclared (first use in this function); did you mean ‘GENHD_FL_NO_PART_SCAN’?
  362 |                 gd->flags |= GENHD_FL_NO_PART;
      |                              ^~~~~~~~~~~~~~~~
      |                              GENHD_FL_NO_PART_SCAN
drivers/mtd/mtd_blkdevs.c:362:30: note: each undeclared identifier is reported only once for each function it appears in

Hmm?

I'm going to revert this one for now, not sure how it could've been
tested in this form.

-- 
Jens Axboe

