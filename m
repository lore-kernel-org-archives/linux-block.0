Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA413C49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 15:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBEE206C2
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568647008;
	bh=5u9h6zrmeI5TGq9mCyWWfiexU7XIPjArpsxU/41x9gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LEdWli7tMKphLJjwASrFL/85BjV4oZJxbrm8qRa+W0A8z36PdMOkn33p7imlxnDF4
	 AZHMPUlAMfQwNus1bqKGLdujFtiImjLmas+ItBof7Vl+at9e81AKUV/KTxK5rBQv/g
	 LPIhojfX1h8huXVCw4kwBGx/keJELLjyc/21CXww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfIPPQs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:16:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41752 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfIPPQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 11:16:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id x4so207349qtq.8;
        Mon, 16 Sep 2019 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=to+g4mrtJdYUkTxkKpAQLy9ttRtsAGqphpzLEO+R2Do=;
        b=k3p4HOtMQrmIbyPz6c5OGR6zKDjk6SwAb5skOSk/70p9X2AUBOqKiVnERofdCGPvuJ
         7XnTCfIUqMbB3GzGT1Rg65tIWDWtrk2EXIRNbvneDZr/lEf92aZYvOj8jDZ8p7wwBEeu
         GzW6Aq+SjNLt94jtH/6A5G+YbVYn5gVzdCIeQdm9ZPp0Aktgy6faZZ7MWjYa5u4Je8IA
         Fgo2vfXKBCI1Y3FEj3C0SqYrKonhjy7OOgrE3uURHf3LQvDoqInFGe4VAVJY6eLxscTQ
         wycQv3/vorliAMyMGOgfwBuTi06Mg7WIFkESkzCwCkAsT2VZ7Jb37HDenfbipCvrglYR
         /rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=to+g4mrtJdYUkTxkKpAQLy9ttRtsAGqphpzLEO+R2Do=;
        b=fUvgImH5tbqqUfzwh3bz8Qq9D1xlJk7y2hobinGTq4lZo4C485KUeA3kkMTjX3bJV5
         nHdDW+JF5xaPwPwSJqel69KceCESgOBFhT5CksHlYDw+9Cf+mDEEHg7lrRdtnRjitFR6
         9rLAWdfSxvBEzCk0SmrBZ1T0MDKOw3QYXAYvOoYveBH1AxiHm5HjRwsxi842IrDgklE2
         FOknVRn0LB3EVOkxZ1SJk7KnIGXF3I6nQche9J46KBzjtmMYrVxbFOuPqiIOBFP1QVFc
         puTmvpEesgp0nTZw1yF1i12kfqC4lF/zZWnciP6GG69DHzzGXoH8B2mxyBq/0m9g+bsB
         UoYQ==
X-Gm-Message-State: APjAAAVfNzSzfy+cf0kwF1WUdtlTKF4Hjy8AR1fAlY7RWcNKLimGqpwW
        Hp+HfjcRgL9Zu6vpn5cYdOY=
X-Google-Smtp-Source: APXvYqyqPrBENt9TqR+iQcs6qeVCttvBTrm43rGMUcnP+AVAJyvGMbCrF6BJPKVAbcooUsjOUopjwA==
X-Received: by 2002:ac8:2497:: with SMTP id s23mr27632qts.329.1568647006769;
        Mon, 16 Sep 2019 08:16:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c30c])
        by smtp.gmail.com with ESMTPSA id m19sm17940669qke.22.2019.09.16.08.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:16:45 -0700 (PDT)
Date:   Mon, 16 Sep 2019 08:16:43 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 0/1] block, bfq: remove bfq prefix from cgroups filenames
Message-ID: <20190916151643.GC3084169@devbig004.ftw2.facebook.com>
References: <20190909073117.20625-1-paolo.valente@linaro.org>
 <80C56C11-DA21-4036-9006-2F459ACE9A8C@linaro.org>
 <c67c4d4b-ee56-85c1-5b94-7ae1704918b6@kernel.dk>
 <1F3898DA-C61F-4FA7-B586-F0FA0CAF5069@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1F3898DA-C61F-4FA7-B586-F0FA0CAF5069@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Paolo.

On Mon, Sep 16, 2019 at 05:07:29PM +0200, Paolo Valente wrote:
> Tejun, could you put your switch-off-io-cost code into a standalone
> patch, so that I can put it together with this one in a complete
> series?

It was more of a proof-of-concept / example, so the note in the email
that the code is free to be modified / used any way you see fit.  That
said, if you like it as it is, I can surely prep it as a standalone
patch.

Thanks.

-- 
tejun
