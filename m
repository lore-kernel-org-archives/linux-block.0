Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58600C31E4A
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3F0208CA
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lRIstcni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389555AbfFMPvu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:51:50 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:36530 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731655AbfFMJLN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 05:11:13 -0400
Received: by mail-yb1-f174.google.com with SMTP id b22so5998263yba.3
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 02:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hdzDaIQivM2GQQjKjPKFTqRgsbrNCZqKbK0V3ZVo6Nc=;
        b=lRIstcniXTx23F3u1CwanJ3jT9Y9GDWZBnk8ih5ZPbzLi4oLEcY1Qs/S8iTuN9JOF7
         4thioH21/1zFEFv1TsO6pKtA6GrAOCQM3xwGiRyU7A4+tAlWQP6dQ4VvCAt3eG8ooEy2
         dR/KfvZI7Zli68tEfmTyINRkXnTaL4xnuifgLztk5DUPlFl7jWVD7Mw9x1I1HPyIKMrM
         HJkhYc2O5YiFMKywVqocyM4ww4HO4dUdeN7p135MlVPVcCWUuRHDyBZUdCbDcnG0ucbU
         F4nSyTpUipCX9W7H3zENc3twMh4NDTuXkMyDATFHVwB5XNaO6PCUjKKc4uESvmcIXVGh
         JFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hdzDaIQivM2GQQjKjPKFTqRgsbrNCZqKbK0V3ZVo6Nc=;
        b=hyGrzd1C5/sp8bwJvebVv6c8q/NJonu0SaEbphb31KPpu02BLKBipcFVTFDlkqzR82
         PWlINWbd5LWhwoRDp3xIlbYjb5oLrh0AV47Jr9MoRnv0+hjLjTaVLvedU4d0JaSmlrGC
         vo0bbBTDrgibHxCp3o78WAWi1vjXnEWvuWsiJpLNI4XzLrNOm9RAh1aSBdokROlmeTU6
         wdA0YNilvJwyB8Q4ooJ/BJMn4M0x0UHBA2LpYT+6o/uYW7D8SNEnUEyqjoZCDsJMFuxS
         eW54c/cnTuLGWprKRC1O/P8msKFPshBGdIZT97OgTHRHcg5Z7gYVrjmamrT+4pmI0NMm
         foTA==
X-Gm-Message-State: APjAAAUnC3B+RJcMjT71OEc79cIT0JcvKzxqqJ6dVizVhlOt07Ayk6bw
        ENmBuq/IqRx73GOhPDGTUo3mk0nVY003zJ09
X-Google-Smtp-Source: APXvYqwiB1JSXJv/GplehKTd8d79Fp2Ps5UxWQYgA68H+h9FLlw/rNDhR2FPb9kv5p4VIMSMzCWuBQ==
X-Received: by 2002:a5b:44:: with SMTP id e4mr44036072ybp.257.1560417072692;
        Thu, 13 Jun 2019 02:11:12 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id p128sm1040304ywp.24.2019.06.13.02.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 02:11:11 -0700 (PDT)
Subject: Re: alternative take on the same page merging leak fix
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20190611151007.13625-1-hch@lst.de>
 <20190612010922.GA17522@ming.t460p> <20190612074527.GA20491@lst.de>
 <20190612101111.GA16000@ming.t460p>
 <5d781312-d28e-5bcc-4294-27facdd4a1e7@kernel.dk>
 <20190613090257.GA13708@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d0eb5ef0-4cb0-d2c0-7f5a-12830e916672@kernel.dk>
Date:   Thu, 13 Jun 2019 03:11:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613090257.GA13708@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/19 3:02 AM, Christoph Hellwig wrote:
> On Thu, Jun 13, 2019 at 03:02:10AM -0600, Jens Axboe wrote:
>>>> Patches 3 and 4 have no dependencies on 1 and 2, and should have
>>>> arguably been ordered first in the series.
>>>
>>> OK, that is good to make patch 3 &4 into 5.2, I will give a review
>>> soon.
>>
>> I'll echo Mings sentiments here, for the series.
> 
> And what does that actually mean?  Do you want me to just resend
> 3 and 4, or can you just pick them up?

Please resend them with the acks/reviews, I'll pick them up asap.

-- 
Jens Axboe

