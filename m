Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EDEC05027
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 21:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBQVl7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBQVl4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 16:41:56 -0500
Received: from mail-il1-x163.google.com (mail-il1-x163.google.com [IPv6:2607:f8b0:4864:20::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F1E64B0E
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 13:41:54 -0800 (PST)
Received: by mail-il1-x163.google.com with SMTP id j11so839455ilf.0
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 13:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNanTuJiFaffs6p61iPp8uSQmlAn6aQ4qdubO70a2yY=;
        b=HgJSHDRUL7tg9AmAP9Fksjg0maa747PQpabvYpdVuHOSy/GpZg70/E4cLeps66V/tV
         qC4aFFsqofptDykOb85lQaJvLc257CKBY4L0vsKeeYcuKiIK7tXlZipVvJ0Eag0Y3+FZ
         8UEabzK/NOPsbjiC8A1MW7z499CTlR7h3968Fmg2PIB9/gTN7SQTp+52g/254HveLkTm
         FWbEp8kiJlBe2VX2mKXmygRRAEYoSUHK1/7mRCXLOpl7A6zacvQIqU1JtueOTBkseW6p
         O+p/MYohQPMbRDH2o4yI5r5G0aepCbAgPi+KRcSOzBfAo3zKDIqM7nkmSNU3RwfN7L+Q
         HVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNanTuJiFaffs6p61iPp8uSQmlAn6aQ4qdubO70a2yY=;
        b=IrfN09lbcNk0QRegvb8gJM1vspnXkWkXUKkrLkZXw22va4OX8XBTZyqueefndWlbT6
         cvWbl4HmVLtwtb/9UxQ5LpEcs3Q15rBBtVzQ8y4YbCna3It2DbWeW/bbvgPekQmD5Z6x
         GKUh5BZOHGNQtY0TL77L3Ab2cZ5Zu9GTeByBbZKq+tWQyiBxmEz7a7gD/ayPkiE6w3sl
         YL2fUn3tgx6WK75zQztXgWYmvLxRieu8PYODFw11gZQkrtCgcymdAELH1jowxuJKQDYD
         VxKoliLDPu0mze1zz1jlpl/7DtOQYvNGvv+he71j/gkaFGVbiuS/XGPc2DQg9QInMBaw
         okQg==
X-Gm-Message-State: AO0yUKUGygh8miP7ZAUGGriWrMT9vGZxP3c7LKxCTbMU65b+pJYl3mIJ
        uhW+8cqXq4J25SadFw8Zp1WlZl3VBJ9TUmbX2w5bpBuxdzjZw4oIJpKejHaWSYU82A==
X-Google-Smtp-Source: AK7set9qv24vhhnsz2IGKkRz0ahqJKiqry6wPHLLBeGPi5dTQbar9+H/VBUJGVP+dGIm1Dn7A4MHCxt/dNON
X-Received: by 2002:a05:6e02:164d:b0:315:7290:428a with SMTP id v13-20020a056e02164d00b003157290428amr1355252ilu.11.1676670113929;
        Fri, 17 Feb 2023 13:41:53 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id m9-20020a056e021c2900b003152992255asm230795ilh.17.2023.02.17.13.41.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2023 13:41:53 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev5.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
        by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id CDADC220E9;
        Fri, 17 Feb 2023 14:41:52 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
        id C7B96E40376; Fri, 17 Feb 2023 14:41:52 -0700 (MST)
Date:   Fri, 17 Feb 2023 14:41:52 -0700
From:   Uday Shankar <ushankar@purestorage.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-ID: <20230217214152.GA1124853@dev-ushankar.dev.purestorage.com>
References: <20230215201507.494152-1-ushankar@purestorage.com>
 <Y+3IoOd02iFGNLnC@infradead.org>
 <20230216192702.GA801590@dev-ushankar.dev.purestorage.com>
 <Y++oTz0ck9OGE4Se@infradead.org>
 <Y++utrkJXuUsD0K4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y++utrkJXuUsD0K4@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Much easier to address a bug in a driver when seeing this message than
> figuring it out after more elaborate hunting. Not seeing the downside
> of preserving/fixing given it is a quick limit check. *shrug*

I tend to agree - considering the check has been here for a while, I
don't know if lower levels will have particularly enlightening logging
(if any at all) for these errors.
