Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF12DEB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 10:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGKKUw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 06:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGKKUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 06:20:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9460EE0
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 03:20:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so8884280e87.2
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 03:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1689070847; x=1691662847;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=PVUO3IRo/r86ZHpIHo6p2mGssmLAdn3Wiwp1qbl6NZg=;
        b=l6xzQzJ0wZ34IfsIs+w4utMMGzrjS8GwYFaO5CLdqUnkpMaN/RPtIqoP1GpB7ws9jw
         PbC0TPm9oDF12T8GtSGP7KKpzSRNd8YnDGR7qSBwHWTd9i8mXHVpwaysRzIxUznYZrVg
         CsLKamLPTZJYCgl/SXxXJAWg483Smcf2MnQ2dJs6K3Y0S31P7IY7WiZNAyKNleFfJukS
         GqJ5m1mnfSDWDWCoXXjX2iOfnbeQOY7Y44/dOW/canQ03nqbexdTI4ciZn/btXQIHyB1
         xDaAqS4WWBhvia/7Pw+grpB5hBXfltxYUOeJ6qFoTyvPVoWg5NjE+3tl2pTbWOqstfrk
         40Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689070847; x=1691662847;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVUO3IRo/r86ZHpIHo6p2mGssmLAdn3Wiwp1qbl6NZg=;
        b=eB3lhDK1V06ipwLGCB4Pg7pSKf66UAb10pghmXrXcLMHG7afwI+ynPseWjUPU8Se6A
         bglr4pcDFlfDbCFzOpR2SG2xD2Wv8bdieVSaFn2LLbdPV9L6K2oemywqAAdGC2KLk9I+
         7+VgrpO9BxvQwE+8yKDg80MR2snGKLXlwoJ8OTEUzYVgL9yDvzvamTQrq/jV9MQguDxm
         ezI8jiFRWCq78ukNMMMogRHmGVk1NBG4jRO+ylZCeNbffJWSSoTdYKQSVwm77gMTb/sN
         FcXNOMDlB8wUCw+gyxzSSDEKC2WBS8N5i8owZpHgPFa6lwxmJ0kdNB7ZpotLsYdabXJJ
         Qp6A==
X-Gm-Message-State: ABy/qLa1BKqQT3ecSj1g20ypvTLd1Icbp3efOiAyf1gMed6Bz+DZrMHB
        jU1YYr9OmHKOiLnNygYaUuyIcw==
X-Google-Smtp-Source: APBJJlFZ0Z9MV5Y+DZ8EwTnzHNYnhwkKaeV67mS31xGtgrw9cGJ095ievyhPP9vnRq7WKGsW2VrPww==
X-Received: by 2002:a05:6512:e9c:b0:4f8:7325:bcd4 with SMTP id bi28-20020a0565120e9c00b004f87325bcd4mr14277883lfb.0.1689070846653;
        Tue, 11 Jul 2023 03:20:46 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id 22-20020ac24836000000b004fb12e0c3eesm254676lft.193.2023.07.11.03.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 03:20:46 -0700 (PDT)
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-2-nmi@metaspace.dk>
 <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
 <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
 <ZKuqt6QAXic3wuRX@infradead.org>
 <ZKvO+81b9fAx2L/r@ovpn-8-31.pek2.redhat.com>
 <ZKvQPAN9OkS3dZ4d@infradead.org> <87a5w3ymff.fsf@metaspace.dk>
 <ZK0RKkXFaQSotxVl@infradead.org> <875y6qzufc.fsf@metaspace.dk>
 <ZK0gcj4j/sRWx2Pl@infradead.org>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH v6 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Date:   Tue, 11 Jul 2023 12:15:18 +0200
In-reply-to: <ZK0gcj4j/sRWx2Pl@infradead.org>
Message-ID: <871qhezr4d.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Jul 11, 2023 at 11:02:15AM +0200, Andreas Hindborg (Samsung) wrote:
>> 
>> Christoph Hellwig <hch@infradead.org> writes:
>> 
>> > On Tue, Jul 11, 2023 at 08:23:40AM +0200, Andreas Hindborg (Samsung) wrote:
>> >> Yet most on-the-wire protocols for actual hardware does support this
>> >> some way or another.
>> >
>> > Supports what?  Passthrough?  No.
>> 
>> Both SCSI and NVMe has command identifier ranges reserved for vendor
>> specific commands. I would assume that one use of these is to implement
>> passthrough channels to a device for testing out new interfaces. Just
>> guessing though.
>
> Vendor specific commands is an entirely different concept from Linux
> passthrough requests.

And yet they are somewhat similar, in the sense that they allow the user
of a protocol to express semantics that is not captured in the
established protocol. Uring command passthrough -> request passthrough
-> vendor specific commands. They sort of map well in terms of what they
allow the user to achieve. Or did I misunderstand something completely?

