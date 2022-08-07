Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F6EC19F2A
	for <linux-block@archiver.kernel.org>; Sun,  7 Aug 2022 19:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiHGTxs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Aug 2022 15:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHGTxr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Aug 2022 15:53:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31AB6474
        for <linux-block@vger.kernel.org>; Sun,  7 Aug 2022 12:53:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w3so9132077edc.2
        for <linux-block@vger.kernel.org>; Sun, 07 Aug 2022 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KSNjU/g/uABeK7DgJdNs6bpwX7SttrPrrtSMzcFQBU4=;
        b=YS+bg3+dthHvsLf+APaAuEwIfsa87dAkJ6XL9CGQZtr1aiJtX0D02R+wQuiAohq4Kz
         Bh3qmQNfqdcddLZNg+2iFwN6n8+SrbLgwbIfRy0a2+qRuBB+MJwxHwKlQ3LPVZwmHpnz
         WE4LRv/+G8ZumwPcbG2NOWWZrxYZBUmTvUnL8XE6Suffg/dqkz2UF9J8xAVEdp70ynzJ
         FtpGr7xYl661N78VLK9TXS5HcOFXXVCE7OoRcSwQam/t+7Xarc4j5jEJzcuYItubOTjN
         N/+5FVyBW+xxOxQF6monqPMaJHjmCHY2KGY+tcMM58bID/soNeCuQJ8HW0YcMq4WPDQO
         lIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KSNjU/g/uABeK7DgJdNs6bpwX7SttrPrrtSMzcFQBU4=;
        b=Iu/QR7aRAEGSXHPSKW49V23a7Go6DaWRvxzC7JgbyrBOu/9DArnIHUV6ZqfJyrPAl7
         J3jaM5NDbI2YzwiM29oqVzl5YwfWPFNoyAzwkBzRMDWawv8HZ0UhD6Ol1FlzxJ+v15Vl
         JLWum7VuCuEv10VZhukJW0Xt3ES2V+oo5l0jKZAhrQgk7RIg2Q3E3H2Xypei/UADGq5J
         M81799PIbcae44RVycQgaaAtJI77Mb1ghJq4tu0sO+5WAzxkVLXXBTpSmoMD5ly8oYs7
         WandQXxfSG4xkKKpx32lXKMMhqrMVsEjAzlvoJpqCe/EYgW4CaOSNm5D/kx3FWb0T6K/
         buGw==
X-Gm-Message-State: ACgBeo38LHbGK5k7Bm+/amqonn7CVUCawj5zz9PsBKyWrBulfu/KAhNH
        3CV8hGNrXWg/j1KhJNBc81RMNyhz2zZYmA==
X-Google-Smtp-Source: AA6agR7x9Zl9jxGqHa/qimd6JaBS49eiXMcJU+FuL/emsWO/J+uT2G5Y1LOCkzPTsmZv/38KN8YGVQ==
X-Received: by 2002:a05:6402:1e88:b0:43c:e8d4:bf27 with SMTP id f8-20020a0564021e8800b0043ce8d4bf27mr15616183edf.401.1659902017188;
        Sun, 07 Aug 2022 12:53:37 -0700 (PDT)
Received: from [192.168.2.28] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id bf17-20020a0564021a5100b0043df042bfc6sm3566644edb.47.2022.08.07.12.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 12:53:36 -0700 (PDT)
Message-ID: <731828af-0ef3-ba04-7115-be8f1d41e1c5@gmail.com>
Date:   Sun, 7 Aug 2022 21:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [git pull] Additional device mapper changes for 6.0
Content-Language: en-US
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Alasdair G Kergon <agk@redhat.com>
References: <YugiaQ1TO+vT1FQ5@redhat.com> <Yu1rOopN++GWylUi@redhat.com>
 <CAHk-=wj5w+Nga81wGmO6aYtcLrn6c_R_-gQrtnKwjzOZczko=A@mail.gmail.com>
 <Yu6zXVPLmwjqGg4V@redhat.com>
 <CAHk-=wj+ywtyBEp7pmEKxgwRE+iJBct6iih=ssGk2EWqaYL_yg@mail.gmail.com>
 <99e17678-8801-ac41-de20-a5f6f60da524@gmail.com>
 <YvAA8fI37owuSe7y@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <YvAA8fI37owuSe7y@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Mike,

there was nothing personal in my reply - sorry
if you see it this way.

Anyway, please stop ad-hominem attacks on me!

I just described what I see as a problem that prevents
us from dropping version parsing.

Technical comments, below, but really, these should go to
dm-devel only to not waste time of others.

On 07/08/2022 20:14, Mike Snitzer wrote:
>> TL;DR: it is *only* for hinting to users what is possibly wrong
>> after activation fails because there is *no* proper error reporting
>> from the device-mapper.
> 
> DM's core and target versions aren't intended to be in service of
> error reporting. You abusing them like that is a fundamental problem.

Perhaps, but there was nothing better. If I missed something,
we can definitely make the code better.

TBH, I do even think that it uses the same logic as libdevmapper library
(and perhaps it dates even before I started to maintain it).

I do not see fundamental problem here, though.

I take is as "The dm-integrity was introduced in kernel/target X",
then I do not expect it working in X-1...

>> Please don't just replace it with bitmaps.
>>
>> It will not bring any better interface while adding more magic with
>> handling compatibility, as we need to use both... see below.
> 
> (I saw your "below", it lacked a coherent explanation for why "we need
> to use both" as a rule moving forward)
> 
> When done properly it will _not_ require both. The version number would
> be incremented one final time and would serve to allow existing
> userspace to run unmodified. But from that point on the bitmap flags
> should be used and all userspace converted to use them.

I just meant that if userspace want to support older kernels,
we need to support both.

If it does not bring fixes for the problem I described, it is just
more code with no effect (for libcryptsetup).

But if you see other reasons, then of course it makes sense.

>> I cannot speak for the others, but for veritysetup (libcryptsetup),
>> the worst that can happen is that the user will get a wrong error message
>> (or just a generic message "something failed, bye").
> 
> You know how to send email to report specific problems and/or submit
> patches. But I really don't recall anything in this category being
> reported by you, certainly not recently... maybe you've just
> internalized or I somehow missed it?

I am sure I mentioned this, but years ago... what I am talking about

1) Some ti->error messages are lost, e.g. in dm-crypt,
   I think example is IV generators constructors
   if (ret < 0) {
      ti->error = "Error creating IV";
   ...
   (And yes, I should fix this myself.)


2) Targets use macros like DMERR, these generate syslog message.
    Getting these messages into userspace is problematic.

    But perhaps this is more problem for libdevmapper we use.

>> (All the crypto options are tricky, I would like to keep at least basic
>> usability and better errors like "seems tasklets are not supported,
>> retrying without tasklets flags.")
> 
> dm-verity's optional "try_verify_in_tasklet" is using tasklets as an
> implementation detail, if they cannot be used (e.g. for FEC) then why
> would fallback to normal verification using a workqueue be reported?

I am talking about situation when user explicitly requests to use tasklets
on CLI and kernel does not support it. Then there must be an error message.

I am not sure if we should automatically fallback to non-tasklets,
but we do this already in other situations (enable-discards, keyring support, ...)

> 
> Or are you referring to something you saw when using dm-crypt's
> no_{read,write}_workqueue options?
> 
> Or are you saying that both the new dm-verity try_verify_in_tasklet
> option and the dm-crypt no_{read,write}_workqueue options should
> fallback to removing those flags and try without them?
> 
> That is a level of AI I have no interest in adding or supporting.
> The user asked for something, if it isn't possible then it should
> fail.

And nobody asked for this as we are already doing this in userspace.

It was really just example to demonstrate when we use target version.

> "Please extend the DM ioctls to somehow add ti->error to the userspace
> response" is a fine feature request. Should help no matter what.
> 
> (Can look to have a phased approach to the error reporting payload,
> start with errno and error message, add more "structured" payload over
> time. Are you referring to JSON or some other format? Whatever systemd
> uses?).

Great, let's discuss this later.

> 
>> Perhaps in the syslog is more info, but usually only at debug level
>> (that is often not visible), and parsing syslog is not the option for us either.
> 
> All errors should be emitted with pr_err() using DMERR(). I've made a
> conscious effort to convert DMWARN() to DMERR() when appropriate. But
> I'll audit all the DM core code and then work through the various
> targets.
> 
> If there are incorrect log levels being used it is a bug, please
> report and/or fix.

Yes, I tried to say that syslog itself as source is problematic
(if you activate many devices in parallel; in multi-tenant environment
when you should not see logs from different users etc).

> There is no way to properly use version numbers to derive what
> actually went wrong. Could you narrow down and isolate the possible
> failure based on version in specific cases? Sure.. but it is insanely
> fragile (especially with stable@ and distro kernels).

It works pretty reliably for years with some minor exceptions that
can be ignored.

Milan
