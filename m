Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6308EC4361B
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00982207B2
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 17:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgLCRuy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 12:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbgLCRux (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 12:50:53 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C96C061A4E
        for <linux-block@vger.kernel.org>; Thu,  3 Dec 2020 09:50:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m5so1545640pjv.5
        for <linux-block@vger.kernel.org>; Thu, 03 Dec 2020 09:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ppnO25OuYQ/1IjELB2kgBioJi4rv6POx6IlxQIXXNpk=;
        b=HOHj6ayscVe3ZO0DpYfNEMtrxcPpXBfSBduTRP26eJAi9qWeDaEaqvnlWyD1tkgsNn
         WHf/c+iph12AtDq5ZPiB0xBf7vpVwaQ+d4FmzkhPANMYu7p/pjev/8GYudVFNTVY2ars
         R0psmS9bdHBmvimevhcc3vnoNApM2yiWbbZqFciw03VA6B2hsct4V9O85JtoFFYiWG/+
         CQ1HnSZiPPrui+eqkQEZ//rCuCzBXtD68Sm5lSes2CW89A6EAEjmGkSAk95oQI7exFis
         skTuSOtL2uFNQ/9INU1C2swi0XB4WpYbH2P6PwK4LjQvHJAXEczMh6WIpsHUAxlFLy2R
         hq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ppnO25OuYQ/1IjELB2kgBioJi4rv6POx6IlxQIXXNpk=;
        b=kSJipE63BTqfXjhSQmD3X7BUjQ6Yme8Z8ZdV9ePnOVjtS+NmngqMW+07GpPJ9RcMsT
         z+9F2ztEtERHKiCGgeAmR0A2iAspfA4kc+mYaJS1s5KYADa9N3p6kmOG91UWIGAwHzZ0
         aK4+NQ9UC64OmB1RneDbFYofwILmtSvyGDCS+DIe+oJzGVl53jT8bbNOxG8N8qwMf7gA
         VFiJpEjT24V8y893RHTL34ihrTswDlb/IIUI2l85IEDw9Q1JM2kKjSjvSo11r5OxVWne
         kiHkTGWeYKYHlgKFyBQ7iBRHb+tRelGTYcfJmv4zuXeo13qEY901QQEN6zPf7k6Vw4zo
         icmQ==
X-Gm-Message-State: AOAM533coaZGSta8XPdDAdXXbA2KNKQ4S6z5QFR/pHNbup1zyTUZicKZ
        /QfiP6OFOkmQxMsdUM2FHLxeDA==
X-Google-Smtp-Source: ABdhPJxllA5bbSYrFdTd4toUUA9bg5VaxzP3LGpwUAiBmd2AiI89u7amTYs88FKICVUaW8O+Hlmcgw==
X-Received: by 2002:a17:90a:7e0f:: with SMTP id i15mr230116pjl.93.1607017806270;
        Thu, 03 Dec 2020 09:50:06 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e66sm2251101pfe.165.2020.12.03.09.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 09:50:05 -0800 (PST)
Subject: Re: [iov_iter] 9bd0e337c6: will-it-scale.per_process_ops -4.8%
 regression
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     David Howells <dhowells@redhat.com>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com,
        Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
 <20201203064536.GE27350@xsang-OptiPlex-9020>
 <CAHk-=wif1iGLiqcsx1YdLS4tN01JuH-MV_oem0duHqskhDTY9A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8124ce0d-c934-0771-5e34-cf5ea030fc08@kernel.dk>
Date:   Thu, 3 Dec 2020 10:50:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wif1iGLiqcsx1YdLS4tN01JuH-MV_oem0duHqskhDTY9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/20 10:47 AM, Linus Torvalds wrote:
> On Wed, Dec 2, 2020 at 10:31 PM kernel test robot <oliver.sang@intel.com> wrote:
>>
>> FYI, we noticed a -4.8% regression of will-it-scale.per_process_ops due to commit:
> 
> Ok, I guess that's bigger than expected, but the profile data does
> show how bad the indirect branches are.

It's also in the same range (3-6%) as the microbenchmarks I ran and posted.
So at least there's correlation there too.

-- 
Jens Axboe

