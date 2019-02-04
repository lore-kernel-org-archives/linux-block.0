Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E621AC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 20:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7092073D
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 20:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfBDUbq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:31:46 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38236 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfBDUbq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 15:31:46 -0500
Received: by mail-wr1-f52.google.com with SMTP id v13so1333406wrw.5;
        Mon, 04 Feb 2019 12:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=antHsuw/vVJmWBDUzzccn0fS6XiezfFcD5Es3uKUq3Q=;
        b=WgMLv9NdZQy1+ESgq8j+HNGfr7aQ81Iqo4yURlJ0/P16oqY6x81BiNeywXCsNRw9uu
         w6geq/WxlCRF8lQrx35PPDCWSQ0m2LkA1PTlRTJUJPZecuzvhdtfWYNqE4H6qEhJ4Ekk
         jyOcRqCUQ6acozmI9CEKr5o01QgmQy8Dkf33z1mPnSKnvJWFhSqm2/8mkEVOSgxtQLj+
         f4hY1QmNnLO6s5kE1kgRSbjlRnIge776LKBy8wDKlTKNgDVRzc+LpOzFfThyLXWr+wvW
         oAqDzkec20KvNYSVwvdGnsYRM9yvZy2v61U3iESn0T0n2dyszAlxljdyjN3czR3AnWot
         0YtA==
X-Gm-Message-State: AHQUAuaUsnzXtf36bstxfJwIOSE6YGqV4ukX7OYffWB8iikr7Yc0siah
        Q4s40IqOmY0TaaMATEvq/0SyXJyO
X-Google-Smtp-Source: AHgI3IbaGrOP4TGXszTgDgXcRKnaNaxxXTQ002dAKNhXMfNixDFkbFTXaR2QfqFX0qwBbfkLp/WsCw==
X-Received: by 2002:adf:f347:: with SMTP id e7mr880844wrp.25.1549312303554;
        Mon, 04 Feb 2019 12:31:43 -0800 (PST)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id b18sm17301478wrw.83.2019.02.04.12.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:31:41 -0800 (PST)
Subject: Re: remove exofs, the T10 OSD code and block/scsi bidi support V4
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        martin.petersen@oracle.com
References: <20190201075557.9249-1-hch@lst.de>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <3be11773-5ea9-4c08-25a5-dc556ded2d6f@electrozaur.com>
Date:   Mon, 4 Feb 2019 22:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190201075557.9249-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/02/19 09:55, Christoph Hellwig wrote:
> The only real user of the T10 OSD protocol, the pNFS object layout
> driver never went to the point of having shipping products, and we
> removed it 1.5 years ago.  Exofs is just a simple example without
> real life users.
> 
> The code has been mostly unmaintained for years and is getting in the
> way of block / SCSI changes, 

For the 4th time: Which ?

> and does not even work properly currently,
> so I think it's finally time to drop it.
> 
> Quote from Boaz:
> 

Hello? anyone home?

Please resend without the below Quote!!!
Because yes I said that but I have also said the opposite. And I have clearly
stated in reaction to the last 3 resends. That I now oppose to the below statement.
And that you should please remove it.

Do your own text please. Don't drag me in the mud

> "As I said then. It is used in Universities for studies and experiments.
> Every once in a while. I get an email with questions and reports.
> 
> But yes feel free to remove the all thing!!
> 
> I guess I can put it up on github. In a public tree.
> 
> Just that I will need to forward port it myself, til now you guys
> been doing this for me ;-)"
> 
> Now the last time this caused a bit of a stir, but still no actual users,
> not even for SG_IO passthrough commands.  So here we go again, this time
> including removing everything in the scsi and block layer supporting it,
> and thus shrinking struct request.
> 

NAK-by: Boaz harrosh <ooo@electrozaur.com>
For what ever that means ...

Cheers
Boaz

