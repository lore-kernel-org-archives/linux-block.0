Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79EEEB64DD
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 07:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjF2HKv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 03:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjF2HKu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 03:10:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8BD2114
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 00:10:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98e109525d6so65841266b.0
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 00:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688022647; x=1690614647;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=mvBygg2aa08XaO2HSEAFwLjrgCcNfa8tx+XRbswbIi8=;
        b=CYn4BQ2bQitOEKyuoeRbF1vm3CVE9nOfCrYKNtEyEVpPgmHQXJf7agf1kt6HQq4314
         wFyBirkA/EeBjG1fN/wNniolJ2ARJBsNe/j+WN+4tyBim4A4ufZaefAkH1ruN0lmyu3s
         zNums1Yf7LlKq+z6cwK6tyhiIFa/Pzbio3j5qkALChyQG0aWRrfC6/yBqMHbKYaV44oO
         zPkPPFr3FI/5aMEDWjIH752Wa9ZvZPihbTthq8b4olUPOZYe+4Cd5RdZQed484M6B1Q7
         u7LCRCtmCLMetYEYx/5+ILHUCT/nikBxWTGFVLJFPOgfl5OJxZiMDnilhik63qFK2kHy
         13JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688022647; x=1690614647;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvBygg2aa08XaO2HSEAFwLjrgCcNfa8tx+XRbswbIi8=;
        b=DWaqDJp2O4g8gb318EJtKCJZzipFApZ6nY34J7Pc6uNlFyK2rMpwDPiUsY2JHlVSwb
         zO/e9gk8soisb3a6CkISz9fKqI2ngC7pR32OX459uZi7hfH/lQejo4mPsWknIyRLDiYn
         W8GiTWHaRKk5yxG/ZIntVVymmzsZeTLuAdc1rcIMcmJtoDysRAw14J387SNKJUYTBR4N
         cRDY5jp/+vkkzlJR6oNUkOixc6v8F0YZp8O9z6U3bUk4UplAs9puxtCqRpfjITGttKpX
         mNyj4mYcPatCCVqwnsdgEGVf5OiECAWRiKXoC25Tg2b5DHaFC6XPAhEVEKseAeGEORDe
         GzPw==
X-Gm-Message-State: AC+VfDxGAtsBfL6Q4VxXwf21qkinqE6pSI/etJMBX3mpWi4fZkILmtl1
        tXtYhrwYmRMYLt49ccCz0SkqMA==
X-Google-Smtp-Source: ACHHUZ7UzIjkr8VlmNsWt5MWQnuZXpaVhxM/jqjB5hPC5bq5F0fqbmRT/6N2SczuiwXW59394C/Bug==
X-Received: by 2002:a17:907:96aa:b0:987:fe18:1c58 with SMTP id hd42-20020a17090796aa00b00987fe181c58mr3087877ejc.35.1688022646904;
        Thu, 29 Jun 2023 00:10:46 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id bu5-20020a170906a14500b0096f6a131b9fsm6532672ejb.23.2023.06.29.00.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 00:10:46 -0700 (PDT)
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-2-nmi@metaspace.dk>
 <d23bf48c-5bc9-aab6-4ca2-ebbb24a0878e@kernel.org>
 <ZJzSjFbzzNxppH7p@ovpn-8-18.pek2.redhat.com>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v4 1/4] ublk: change ublk IO command defines to enum
Date:   Thu, 29 Jun 2023 09:09:07 +0200
In-reply-to: <ZJzSjFbzzNxppH7p@ovpn-8-18.pek2.redhat.com>
Message-ID: <87a5wizqto.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming Lei <ming.lei@redhat.com> writes:

> On Thu, Jun 29, 2023 at 07:47:47AM +0900, Damien Le Moal wrote:
>> On 6/29/23 04:06, Andreas Hindborg wrote:
>> > From: Andreas Hindborg <a.hindborg@samsung.com>
>> > 
>> > This change is in preparation for zoned storage support.
>> > 
>> > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> > ---
>> >  include/uapi/linux/ublk_cmd.h | 23 +++++++++++++++++------
>> >  1 file changed, 17 insertions(+), 6 deletions(-)
>> > 
>> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
>> > index 4b8558db90e1..471b3b983045 100644
>> > --- a/include/uapi/linux/ublk_cmd.h
>> > +++ b/include/uapi/linux/ublk_cmd.h
>> > @@ -229,12 +229,23 @@ struct ublksrv_ctrl_dev_info {
>> >  	__u64   reserved2;
>> >  };
>> >  
>> > -#define		UBLK_IO_OP_READ		0
>> > -#define		UBLK_IO_OP_WRITE		1
>> > -#define		UBLK_IO_OP_FLUSH		2
>> > -#define		UBLK_IO_OP_DISCARD	3
>> > -#define		UBLK_IO_OP_WRITE_SAME	4
>> > -#define		UBLK_IO_OP_WRITE_ZEROES	5
>> > +enum ublk_op {
>> > +	UBLK_IO_OP_READ = 0,
>> > +	UBLK_IO_OP_WRITE = 1,
>> > +	UBLK_IO_OP_FLUSH = 2,
>> > +	UBLK_IO_OP_DISCARD = 3,
>> > +	UBLK_IO_OP_WRITE_SAME = 4,
>> > +	UBLK_IO_OP_WRITE_ZEROES = 5,
>> > +	UBLK_IO_OP_ZONE_OPEN = 10,
>> > +	UBLK_IO_OP_ZONE_CLOSE = 11,
>> > +	UBLK_IO_OP_ZONE_FINISH = 12,
>> > +	UBLK_IO_OP_ZONE_APPEND = 13,
>> > +	UBLK_IO_OP_ZONE_RESET = 15,
>> > +	__UBLK_IO_OP_DRV_IN_START = 32,
>> > +	__UBLK_IO_OP_DRV_IN_END = 96,
>> > +	__UBLK_IO_OP_DRV_OUT_START = __UBLK_IO_OP_DRV_IN_END,
>> > +	__UBLK_IO_OP_DRV_OUT_END = 160,
>> > +};
>> 
>> This patch does not do what the title says. You are also introducing the zone
>> operations, and the very obscure __UBLK_IO_OP_DRV_XXX operations without an
>> explanation. Also, why the "__" prefix for these ? I do not see the point...
>
> It should be to reserve space for ublk passthrough OP.
>
>> Given that this is a uapi, a comment to explain the less obvious commands would
>> be nice.
>> 
>> So I think the change to an enum for the existing ops can be done either in
>> patch 2 or as a separate patch and the introduction of the zone operations done
>> in patch 3 or as a separate patch.
>
> Also it might break userspace by changing to enum from macro for existed
> definition, cause userspace may check something by '#ifdef UBLK_IO_OP_*',
> so probably it is better to keep these OPs as enum, or at least keep
> existed definition as macro.

I can change it back to `#define` again, no problem. I only changed it
to `enum` on request from Ming [1]

Best regards,
Andreas

[1] https://lore.kernel.org/all/ZAHeWieKXtgYUbvz@ovpn-8-18.pek2.redhat.com/

