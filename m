Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5778DC18DF5
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 12:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7B920831
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 12:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUvVq/NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7B920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeKTXXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:23:08 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36305 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbeKTXXI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 18:23:08 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so3312822itj.1
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 04:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VF1vQMfRkcB5pYEIP10m2Fp1BBbVbneNsZsyp3kJaoM=;
        b=pUvVq/NJn0TtWERB3bNtaiqeNqyjeCdrQSWxjEvtbU8c0T0j+dS+L0vVu4Vic39Wyk
         mdGXJO0u6rsAB+GGk5TwjW4O4Ehp/D0abrWKgpavajXkIYc+vLUCSbEGHAsnZRgtzeoj
         sSO8uMCS7edS6wJyjrCuxYduMLCQly71j8HshCrxY3EqooQzJZX3vWMZatHHFxZgJXr/
         jVQ1e4kAv561NW5a+duWBbmo1ZIvKZkb7ko2DKHtKUAOUX5IvO/WVQv43GjEMCt+DDtV
         +pSeXf6mYy47GNjMxBalP1FerCaNScz/dzL9fONEngBM3oXCOJAdMQ99OKv1EHlIxIYV
         FA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VF1vQMfRkcB5pYEIP10m2Fp1BBbVbneNsZsyp3kJaoM=;
        b=cgm3pp51XrLJsN1bgPx7o1WJN5AzvoPPtnrwRDLKrGjeN1UEn3EQY4+10V6CUURE2D
         kxYUwbVCc5vvA2oRFsliiF2KAr+uucaxlg9ZY83syKF3wQMCmiDY3xHfNsroSlv2v9Ky
         HVOVivUFQyU+mzoyhhp0cLLTPLlg7t9GgPP+D2jBeI/KcFX37no+yl5pTLBZxqoYFBB+
         En6W3twP3Ky3NWEbpOyZH44yBJ+J640IofWxwP+7+eanmMsTIwIy7iTx58SnM5hUs73G
         z8HdaLpMvs6Uq9YPNglynad8VkoDhoYgTQVYsVN1T9Zb/7i3WkqF/paVxOnQ3p4m5p8F
         tagQ==
X-Gm-Message-State: AA+aEWaqmiVvJxeNnh1pxtb34ORWuE0stTY1yU/Ct4DLsPDx+heR3reo
        OrV/9juA+ZbaRX4WVTJWPWD/MbYJ1NUp+9Ktwpysqw==
X-Google-Smtp-Source: AJdET5fsSgyDix+wGz7Pwz/bmX4Fi7+C6s769z1SuioZVB2gUG4OXkJW02qQW9+AVQ4M5NAvOsoDFEuj+iEVsdHPEls=
X-Received: by 2002:a02:516:: with SMTP id e22mr1590689jad.82.1542718447809;
 Tue, 20 Nov 2018 04:54:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Tue, 20 Nov 2018 04:53:47
 -0800 (PST)
In-Reply-To: <20181120120540.GA14861@kroah.com>
References: <20181112094406.GB391@ming.t460p> <20181112164848.GA1790@roeck-us.net>
 <20181112200236.GA4415@kroah.com> <20181113002226.GA4455@ming.t460p>
 <20181113004124.GC4455@ming.t460p> <20181114110827.GA31430@ming.t460p>
 <20181114151410.GB26378@kroah.com> <20181115003616.GA32603@ming.t460p>
 <20181115005658.GA24847@kroah.com> <CACT4Y+bSzPM022bGMmj4GQ_YHVsVqd6r+NTC4+fRrRT+yjAjEw@mail.gmail.com>
 <20181120120540.GA14861@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 20 Nov 2018 13:53:47 +0100
Message-ID: <CACT4Y+abDYfK0bD+5E_2T_hR=-0CbJzWnEVVJTTLYAi1-QCx1w@mail.gmail.com>
Subject: Re: kobject lifetime issues in blk-mq
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 20, 2018 at 1:05 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Nov 20, 2018 at 12:34:40PM +0100, Dmitry Vyukov wrote:
>> On Thu, Nov 15, 2018 at 1:56 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Thu, Nov 15, 2018 at 08:36:17AM +0800, Ming Lei wrote:
>> >> > So even if you think the kernel is not going to do this, remember, you
>> >> > have no control over it.  Reference counted objects are done this way
>> >> > for a reason, you really do not know who has a reference and you really
>> >> > do not care.
>> >> >
>> >> > You are just papering over the real issue here, see my previous email
>> >> > for how to start working on resolving it.
>> >>
>> >> IMO, there isn't real issue, and the issue is actually in 'delay release'.
>> >
>> > Nope, sorry, that is not true.
>> >
>> >> Please look at the code in block/blk-mq-sysfs.c, both q->mq_kobj and all
>> >> ctx->kobj share same lifetime with q->kobj, we even don't call get/put
>> >> on q->mq_kobj & all ctx->kobj, and all are simply released in q->kobj's
>> >> release handler.
>> >
>> > How do you "know" you are keeping those lifetimes in sync?  The joy of a
>> > kobject is that _ANYTHING_ can grab a reference to your object without
>> > you knowing about it.  That includes userspace programs.  Yes, sysfs is
>> > now much better and it trys to release that reference "quickly" when it
>> > determines you are trying to delete a kobject, but it's not perfict,
>> > there are still races there.
>> >
>> > And that is what the delay release code is showing you.  It is showing
>> > you that you "think" your reference counting is wrong, but it is not.
>> > It is showing you that if someone else grabs a reference, you are not
>> > correctly cleaning up for yourself.
>> >
>> > Never think that you really know the lifetime of a kobject, once you
>> > realize that your code gets simpler and you can then just "trust" that
>> > the kernel will do the right thing no matter what.
>> >
>> > Because really, you are using a kobject because you want that correct
>> > reference counting logic.  By ignoring that logic, you are ignoring the
>> > reason to be using that object at all.  If you don't need reference
>> > counting, then don't use it at all.
>> >
>> > And if you need sysfs files, then you need to use the kobject and then
>> > you need to handle it properly, because again, you do NOT have full
>> > control over the lifetime of your object.  That's the basis for
>> > reference counting in the firstplace.
>> >
>> > So this code is broken without me evening having to look at it, please
>> > fix it to handle release properly.  Again, the kernel tried to tell you
>> > this, but you hacked around the kernel core to remove that warning
>> > incorrectly.  Please go read the kobject documentation again for even
>> > more details about this than what I said here.
>> >
>> > thanks,
>> >
>> > greg k-h
>>
>> Whoever is the right person to fix this, please prioritize this to the
>> degree possible.
>> This issue does not allow to use DEBUG_KOBJECT_RELEASE in any
>> automated testing (in particular syzbot) on both upstream and stable
>> trees. We have to disable it for now, so other bugs won't be noticed
>> and will pile up.
>
> Patches for this have already been posted :)


This is great.
What is the patch name? I can't find anything that looks relevant on
LKML searching by kobject.
