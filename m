Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0AC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 23:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3926221473
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 23:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Dqd+pgXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeLQX1m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:27:42 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:41671 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeLQX1m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 18:27:42 -0500
Received: by mail-pl1-f180.google.com with SMTP id u6so6851404plm.8
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 15:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=befkiifOPgb10OSIiGYZyt/6yhq/Cqzk7HcT/MxQEqA=;
        b=Dqd+pgXHFE/XSM6xDZFzy7o5NT2AriprCFDosq8XtL9h9suIq5nBCtzu0/sf3GGzon
         JCQZBS4iyHgflk16bE8PdYZE6t00DuR7bI+1if9GFFs6N8ulXnFXJKQHgk+FaStrTvWw
         fkW8H/RPsAzdHSB1NEd9xnVZ7edZwmLwYC9Sbxf3wokcN0R2NGP3X513ZTVr17bmGNNs
         K9+hgbjICOoSjvIcPSYEPfimuu56C0p254Ia/5xHsxPpS6cczSF74YNhhd/i3DZt8SVc
         k9i83VQ5JUPqRX2OgkvJSMycwtlbZRZ7TEww7uRzArAkuCYoaO8GRf5ldS5mA0CKOnEj
         CBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=befkiifOPgb10OSIiGYZyt/6yhq/Cqzk7HcT/MxQEqA=;
        b=DRBDkDfzDsAA5+zEyn2vc+rFe5cY74s9Z2ziXuHRdYIgZtJuLx82USDFN4NAHFFUKB
         9qHCV8iKdM9SXTp9I2TFujVCPs6Ten9LI7hLereVzVZ4vO13IOoecC1FSXln1mUp82aO
         cXHydpqSF5M6Xb0fkuGAw/6XKylAe4M8MWiaGGLjej6JXciFsh1teJVe9E5pMdoDL7Cm
         rvPQxtPmMZdN9K2hnsW588XmPPFgQ3RsH1IjQuGNp+6ZSR25EzBVBRygjp7VQ7vm5fea
         OjYRzk+FKOTskWpnGp7oc6aBzGjsr9ZXQ07XbzSNocuf+HL/9vwa12JVKFssuBG+O0nc
         NVTA==
X-Gm-Message-State: AA+aEWbRaHUghANflCC3hUTwZGkX3jwr852FM0gMFpRaPH5FnSnRBjUG
        rM5vc7s/0sQpyQRSngjpLe2uUvazyuHckg==
X-Google-Smtp-Source: AFSGD/V2sppqVaSSJcp0amMRJ2lfY/Hp863/nKbu3nqIswkrdzIm3bUD/ORhpxX7x4n1/WEQbcdcgA==
X-Received: by 2002:a17:902:a60f:: with SMTP id u15mr13591484plq.275.1545089260913;
        Mon, 17 Dec 2018 15:27:40 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z191sm15612992pgd.74.2018.12.17.15.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 15:27:39 -0800 (PST)
Subject: Re: Upcoming merge window
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6fe5169f-8032-ac2a-ecb7-f845c56b1d73@kernel.dk>
 <1545088576.185366.443.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8ae21d8c-81a1-891a-66c4-c94ff8bee20b@kernel.dk>
Date:   Mon, 17 Dec 2018 16:27:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545088576.185366.443.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 4:16 PM, Bart Van Assche wrote:
> On Mon, 2018-12-17 at 11:28 -0700, Jens Axboe wrote:
>> As I'm sure you're all aware, the merge window is coming up. This time
>> it happens to coincide with that is a holiday for most. My plan is to
>> send in an EARLY pull request to Linus, Thursday at the latest. If you're
>> sitting on anything that should go in with the initial merge, then I need
>> to have it ASAP.
>>
>> I'll do a later pull about a week in with things that were missed, but
>> I'm really hoping to make that fixes only. Any driver updates etc should
>> go in now.
> 
> Hi Jens,
> 
> If I run blktests/srp/002 against Linus' master branch then that test passes,
> no matter how many times I run that test. If I run that test against your
> for-next branch however (commit 6a252f2772c0) then that test hangs. The output
> of my list-pending-block-requests script is as follows when the hang occurs:

Ugh, I'll try and run that here again, that test is unfortunately such a pain
to run and requires me to manually install multipath libs (and remember to
uninstall before rebooting, or udev fails?).

I'll take a look!

-- 
Jens Axboe

