Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAC1C433E3
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 20:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA702072D
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 20:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aSZhdkNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgHQUDC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbgHQUCW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 16:02:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD2C061345
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 13:02:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o5so8635096pgb.2
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=97DJCt1f0pZE/lulXm7MIIWiJdssbmLKs4FWP+jsWew=;
        b=aSZhdkNSZ87cEFa5bVOxaRgbLX85Ac+f9y0d86ayXObRrHbI44P6QsGc3j0vxCaOtG
         T2k2WOgfibXFL7wthStQUZ2a3THDVNOGIm8YJURtA34YheOr2MAVAuh07KvbwkyanYJS
         0EG510E/ggHXtfUb6SqMiyn275eeX4FnCQjVBA0Ynkest98IGBIFATGO7FCiNvsrRbkh
         fmWOvmbqhkjk1q/XQS+NvaPIgrNKptwTVoidsz8P1vd8W5lrCq8X1NqQRsc/NszaPSZV
         B+EkeoLweuq1QOusC/DDv9aQ54VFoeSpo/Y8VIPH3trT8rbQk4iBVBt328RQJCy4a+pu
         mrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=97DJCt1f0pZE/lulXm7MIIWiJdssbmLKs4FWP+jsWew=;
        b=RdBFjck+ZjPejjJsnj0mVGTmQ6js+zkkoA+GaG1bU0KG/3OlYbCHi37sraki87lOld
         guOo/T78y/Oikp7N0hDXMiZsv0EmUSknX+Xb7m0rUZ/BHF6hGgQBYUvpuSxZKqshR9Xp
         aHKlSXiQ7w4gOlaEFbWxC1PxZn0NLoaj8e49/8BPbkbSxa6V5YF4rdWj+fkRKMxjXGXX
         K+Nb+XsaiTXURtUlN/M9AcSlsaen4f/QwN2xpuSoPrP+JyF4Kv5Y+4ZB1tuw1epCMl/A
         cR9MBloS7tzT87xZc3RI/BOLWYbM3i0D4kHX+uOah5uzbWfS8DfayMQHowPLqaST9xaK
         Ulcw==
X-Gm-Message-State: AOAM530KWNA5ryNd9OkpaVUETsa6J0yaXiAEr6kCPuomR9ZTCygnF4w/
        MiNghsnC10M6VnVaIyFtyy13gA==
X-Google-Smtp-Source: ABdhPJx6fgKnzdqFet7WfKg8Bw76iQ/G91m6PuMxHTNY08ReQtFVhesqdO2JpfqR2BskRMIqTcZ09Q==
X-Received: by 2002:a63:d143:: with SMTP id c3mr10873272pgj.306.1597694541448;
        Mon, 17 Aug 2020 13:02:21 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:bd62:5cef:d7f8:5bff? ([2605:e000:100e:8c61:bd62:5cef:d7f8:5bff])
        by smtp.gmail.com with ESMTPSA id c27sm18199498pgn.86.2020.08.17.13.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 13:02:20 -0700 (PDT)
Subject: Re: [PATCH] block: convert tasklets to use new tasklet_setup() API
To:     Kees Cook <keescook@chromium.org>
Cc:     Allen Pais <allen.cryptic@gmail.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, 3chas3@gmail.com,
        stefanr@s5r6.in-berlin.de, airlied@linux.ie, daniel@ffwll.ch,
        sre@kernel.org, James.Bottomley@HansenPartnership.com,
        kys@microsoft.com, deller@gmx.de, dmitry.torokhov@gmail.com,
        jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, maximlevitsky@gmail.com, oakad@yahoo.com,
        ulf.hansson@linaro.org, mporter@kernel.crashing.org,
        alex.bou9@gmail.com, broonie@kernel.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, mitch@sfgoth.com, davem@davemloft.net,
        kuba@kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        openipmi-developer@lists.sourceforge.net,
        linux1394-devel@lists.sourceforge.net,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-s390@vger.kernel.org,
        linux-spi@vger.kernel.org, devel@driverdev.osuosl.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
 <20200817091617.28119-2-allen.cryptic@gmail.com>
 <b5508ca4-0641-7265-2939-5f03cbfab2e2@kernel.dk>
 <202008171228.29E6B3BB@keescook>
 <161b75f1-4e88-dcdf-42e8-b22504d7525c@kernel.dk>
 <202008171246.80287CDCA@keescook>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df645c06-c30b-eafa-4d23-826b84f2ff48@kernel.dk>
Date:   Mon, 17 Aug 2020 13:02:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202008171246.80287CDCA@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/17/20 12:48 PM, Kees Cook wrote:
> On Mon, Aug 17, 2020 at 12:44:34PM -0700, Jens Axboe wrote:
>> On 8/17/20 12:29 PM, Kees Cook wrote:
>>> On Mon, Aug 17, 2020 at 06:56:47AM -0700, Jens Axboe wrote:
>>>> On 8/17/20 2:15 AM, Allen Pais wrote:
>>>>> From: Allen Pais <allen.lkml@gmail.com>
>>>>>
>>>>> In preparation for unconditionally passing the
>>>>> struct tasklet_struct pointer to all tasklet
>>>>> callbacks, switch to using the new tasklet_setup()
>>>>> and from_tasklet() to pass the tasklet pointer explicitly.
>>>>
>>>> Who came up with the idea to add a macro 'from_tasklet' that is just
>>>> container_of? container_of in the code would be _much_ more readable,
>>>> and not leave anyone guessing wtf from_tasklet is doing.
>>>>
>>>> I'd fix that up now before everything else goes in...
>>>
>>> As I mentioned in the other thread, I think this makes things much more
>>> readable. It's the same thing that the timer_struct conversion did
>>> (added a container_of wrapper) to avoid the ever-repeating use of
>>> typeof(), long lines, etc.
>>
>> But then it should use a generic name, instead of each sub-system using
>> some random name that makes people look up exactly what it does. I'm not
>> huge fan of the container_of() redundancy, but adding private variants
>> of this doesn't seem like the best way forward. Let's have a generic
>> helper that does this, and use it everywhere.
> 
> I'm open to suggestions, but as things stand, these kinds of treewide

On naming? Implementation is just as it stands, from_tasklet() is
totally generic which is why I objected to it. from_member()? Not great
with naming... But I can see this going further and then we'll suddenly
have tons of these. It's not good for readability.

> changes end up getting whole-release delays because of the need to have
> the API in place for everyone before patches to do the changes can be
> sent to multiple maintainers, etc.

Sure, that's always true of treewide changes like that.

-- 
Jens Axboe

