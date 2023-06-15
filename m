Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280DCEB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 14:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbjFOORl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbjFOORk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 10:17:40 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921112D47
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 07:16:56 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b3a6469623so35187675ad.3
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 07:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686838609; x=1689430609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEE79C9sZ24uJwsEkPOMQUP+aLPLfbJ/skcIWbFp5v8=;
        b=kRehgR1WA4nBJNMMhBHUYVsf/bBTNFKPItsfSa7MPxhXF1kmkrXke2fg1TDqCqgHFE
         PLU5accfdL9BDa8ndPoAzh8vsWLc/d7jVc378MG1fl1Yau66oexJS4Lf1bTZvjOBU7Hc
         c3V6wD5jKTyZ0flg6OcXpUNX32nKNGTQqkpGr9j8GFLwCJiYcuWkJNX6/YjOmKP6y7Mw
         ouclmbau7ZYAsG08fZ3HiiJYtuDOJ/xcUoBrq1YfQUg+8w4F+DEc77W2HMRSTGxIHPwn
         pOP7aIU+K3VbiWa/GOQh+pCGlkfebLQSzRqUqMbZ7PZA/fRmlOt4GjzLNgRxlKfHtMjx
         +2Uw==
X-Gm-Message-State: AC+VfDzKwnSZitg8JU8z0pIrunMIH6+06gUdYCteJdWrGmeHjH0fHi3j
        +ZZ4y0W2zJ08rVKQHAFsdlc=
X-Google-Smtp-Source: ACHHUZ5ieUp24214s92pB1gK2BQhP+sAkHI9qQFxrBkmE09ef3M+og8T6/m7+Nh2WgeRgD4ATj3E7Q==
X-Received: by 2002:a17:902:e884:b0:1b5:16f2:a4e3 with SMTP id w4-20020a170902e88400b001b516f2a4e3mr1784492plg.30.1686838609358;
        Thu, 15 Jun 2023 07:16:49 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ec8400b001a922d43779sm14180201plg.27.2023.06.15.07.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 07:16:48 -0700 (PDT)
Message-ID: <1a829bad-1914-91fb-0c54-5e06fe304e49@acm.org>
Date:   Thu, 15 Jun 2023 07:16:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/8] Support limits below the page size
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>
References: <20230612203314.17820-1-bvanassche@acm.org>
 <5041fc15-2c6c-b91e-6fb6-5eac740f75eb@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5041fc15-2c6c-b91e-6fb6-5eac740f75eb@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/23 19:22, Jens Axboe wrote:
> On 6/12/23 2:33?PM, Bart Van Assche wrote:
>> We want to improve Android performance by increasing the page size
>> from 4 KiB to 16 KiB. However, some of the storage controllers we care
>> about do not support DMA segments larger than 4 KiB. Hence the need
>> support for DMA segments that are smaller than the size of one virtual
>> memory page. This patch series implements that support. Please
>> consider this patch series for the next merge window.
> 
> I'm usually a fan of putting code in the core so we don't have to in
> drivers, that's how most of the block layer is designed. But this seems
> niche enough that perhaps it's worth considering just remapping these in
> the driver? It's peppering changes all over delicate parts of the core
> for cases that 99.9% don't need to worry about or should worry about.
> I will say that I do think the patches do look better than they did in
> earlier versions, however.
> 
> Maybe we've already discussed this before, but let's please have the
> discussion again. Because I'd really love to avoid this code, if at all
> possible.

Hi Jens,

These are my arguments in favor of having this functionality in the 
block layer core instead of in the UFS driver:
* This functionality is useful for multiple block drivers. It is also
   useful for  block drivers with a max_segment_size limit less than 64
   KiB on systems with a 64 KiB page size. E.g. the sbp2 driver and
   several ATA and MMC drivers set the max_segment_size limit to a value
   less than 64 KiB.
* The UFS 3.1 devices in my test setup support read bandwidths up to 2
   GiB/s and more than 100K IOPS. UFSHCI 4.0 controllers support a link
   bandwidth that is the double of UFSHCI 3.x controllers and also
   support higher queue depths (up to 512 instead of 32). In other words,
   performance matters for UFS devices. Having the SCSI core build an SG
   list and making the UFS driver rework that SG list probably would
   affect performance negatively.
* The MMC driver is more complicated than needed because the block layer
   core does not yet support the limits of MMC devices. I think that this
   patch series will allow to simplify the MMC driver. From
   drivers/mmc/block.c:

	/*
	 * The block layer doesn't support all sector count
	 * restrictions, so we need to be prepared for too big
	 * requests.
	 */

* Care has been taken not to affect performance or maintainability
   of the block layer core in a negative way.

Thanks,

Bart.
