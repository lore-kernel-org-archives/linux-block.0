Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3046DC43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 03:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348016AbiFPDPb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 23:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357782AbiFPDPa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 23:15:30 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2E336E0F
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 20:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655349329; x=1686885329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+htf3H5mXi+bpY+3WsjUtT1paQsBXP3XJbG96NvP744=;
  b=ijxTuPWEaMsrPUzSYJd5nhVLP1xw9fjxaGbADQaNQPgJ3R5XMHFWbQ6l
   NDWom/5p1y8wKE3M9NAlW1zCRkITom0uxUIGcMHlyP7byoJegNCxxVjIZ
   1O7pgm0zqKViRFJ26jKcxXDxPU4IknS8DncYFCM9NArylY+4jS22AGC9+
   RwZvd0WnAr90A2e+ld6L92rdgcEsHKLJ25pnH28CfiGZMzdKCThWE5gZn
   qJkyUcIkdJjndAueKO01dxmGuIhoZn8E5o5+ggVALqMvVG5fj0yUczSBu
   SQ0cRrBSqkdfHyx2XNkFEXlmF/FZoVrKKtL+CDakw19hTdM0ttTDuStVp
   w==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="307586461"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 11:15:28 +0800
IronPort-SDR: cc2RJEzd+80oHQWraCPmg1MVpHXOiO4PSHxaE78of4DFyLsAs+2mEdvU1Vr0sr5N32yc/BoJTr
 YT/zaPc3cvFytcwcUWd92/UdL/bjIXlNCc2giTN2NmbQimxqLN12jWN3Ae/zreyZCMZl4u0ujd
 Ew8l8IaoUzbZD03Gr9+W1k+ifbBfBNskIWwMhJo7pcOIBRty2OyQ1SLQMDy7egOtRYoOi0GL9g
 LfsQpIpmd7r/qfJ3j6AzIRwx7YPAVyPOkTA9tDsAcQ5dL3On1rCQIXa18cZW/vYkXSFGQoOXKN
 /Rb9AK0+bJu0Yw7fmxBAU5Zj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 19:33:51 -0700
IronPort-SDR: iWyScfn+qAR1NF7SPVxfVd3y3wq/hobugJIVg4Yj07Fld/KeOoiBNK4RFogNX4SBYeMmEr4K23
 MiUlt+PtQ0kxT2lnne9QuPQ0ZeYXKHhlPSYBCvIaBnWFRBJO9IXBFCmYZV6cugNyyaI7ZcoVoK
 3+vFZBOvcTFFL+peur04NLYlNB4b+/ndUgD99CPC2RzZ0USmy4l/yLYmiK5JMh1BeYa0xPok+N
 gXHXc0bOjLu/dy8rhFc5SgrEz2+cF2TFv4fQ250s80EKNsjW0Va9IZH59r0KIGe2y3VZyW8lg8
 wMs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 20:15:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNnNv6cCpz1Rvlx
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 20:15:27 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655349327; x=1657941328; bh=+htf3H5mXi+bpY+3WsjUtT1paQsBXP3XJbG
        96NvP744=; b=VQ7Jg0hqtAQfC67LH1J2NF522Z2t6OOdanUpyzbOYTm6TSizdxo
        x9umz5Tv8EyFHPFbhKtkWQXLUiFsTL0X1ADYv/cGxwRN6ljwBAAAB8jKhQ8QDT/2
        0CEulHc4yCrX4i9reAHqS9S9M9zB/vS0DVpjH5EI7OERCgLMZ2oNMvxkqa0sCwwi
        CzJT6CyOn1c0PQ4z5jhllNcHhVIYBjAwO6VpfdqokZHGBQ/fa92w48CL9NBNBZlI
        nSDKR7aJe85rrlCdURYQQwwLh6+KpGbwwUzgXjB6c1qqowJAzFLZFJOyI4ZfhJKF
        +Is7D1eSAgOOGBqN8IqAVcRKbPu6AsbIUFA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tFZQEqS-x188 for <linux-block@vger.kernel.org>;
        Wed, 15 Jun 2022 20:15:27 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNnNt5w9Pz1Rvlc;
        Wed, 15 Jun 2022 20:15:26 -0700 (PDT)
Message-ID: <ece0af04-80c8-e0c3-702b-0d0d17f61ea9@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 12:15:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 8/8] block: Always initialize bio IO priority on submit
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20220615160437.5478-1-jack@suse.cz>
 <20220615161616.5055-8-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220615161616.5055-8-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/22 01:16, Jan Kara wrote:
> Currently, IO priority set in task's IO context is not reflected in the
> bio->bi_ioprio for most IO (only io_uring and direct IO set it). This
> results in odd results where process is submitting some bios with one
> priority and other bios with a different (unset) priority and due to
> differing priorities bios cannot be merged. Make sure bio->bi_ioprio is
> always set on bio submission.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   block/blk-mq.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e17d822e6051..e976f696babc 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2793,7 +2793,13 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
>   
>   static void bio_set_ioprio(struct bio *bio)
>   {
> +	unsigned short ioprio_class;
> +
>   	blkcg_set_ioprio(bio);

Shouldn't this function set the default using the below "if" code ?

> +	ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
> +	/* Nobody set ioprio so far? Initialize it based on task's nice value */

I do not think that the ioprio_class variable is useful.
This can be:

	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
		bio->bi_ioprio = get_current_ioprio();

> +	if (ioprio_class == IOPRIO_CLASS_NONE)
> +		bio->bi_ioprio = get_current_ioprio();
>   }
>   
>   /**

Beside this comment, I am still scratching my head regarding what the 
user gets with ioprio_get(). If I understood your patches correctly, the 
user may still see IOPRIO_CLASS_NONE ?
For that case, to be in sync with the man page, I thought the returned 
ioprio should be the effective one based on the task io nice value, that 
is, the value returned by get_current_ioprio(). Am I missing something... ?
	
-- 
Damien Le Moal
Western Digital Research
