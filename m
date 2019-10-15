Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B781ECE58F
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 22:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4F32064A
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 22:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571178116;
	bh=rPbTSoHNEIC5WjuGfABGhzt2oAh6+ric+JzfcxM3/x4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wnalv3TATvXbPHIvyBEWj6cAPg1nMnI+KfK1PiJ/EwXu/ETWVuzuA1ERtoxSY/e0k
	 W93gXWI3UrGF0r38kT6H4BsRoCtEc1rOTJ4MOy9+LmgcCl7PyevizrTiN79JKIgUkW
	 nwHWbCkXATHGoSg+uKetE1KxAVxgNsGjvUa3X4rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbfJOWV4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:21:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35956 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfJOWVz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 18:21:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so21891758ljj.3
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/Zz9M4vXV5ymfLbgnz4oj5mAYZiyyFZ4Ij6h9abXFA=;
        b=AlIXJO/ZLBv/p7d/ORSQnj90qcyxXZ/L4tcwMN1ksd4hi9eaymWS714WViotqQRLhk
         vIRHrilEHfQt3hkm1+JjO4o2Ud7MKCdkuXafJuo44Fo4GYyzQ/9AmESct2Xx7IfOK7Ok
         haqnjvvfI/PnFSGBeuzLe9ZId2U0u1ulJkPj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/Zz9M4vXV5ymfLbgnz4oj5mAYZiyyFZ4Ij6h9abXFA=;
        b=JfmUN9mQobe80Fo/ocs39YFcnwpsO82bXNI2eAIUP2Q4CJi63u4XVKG8UlEBEzeO05
         GdL5rBrAn12rer2gYq4zeGx/mD5qsvS/ayY5NJX0BMZO4+8oSrHcurN0oFkwKhKkeUSM
         V47el55ZklVu0luVMLzXwMxL7CLWH4K765uFJbGIi0ppwS3zV0LHtbaqf9fQIkdjjKjS
         N5QPpURqxlvUPxzjZM9ueNYY3LMejdpK+bUxjhiUWsWrSsUqIAp83ZkETF+UcDN4tGRK
         wvpz7NWSflAW0Z1P9swe09ZjmUx464xUGpbw2b3A90CcQlSHJga8QatoXKxPEcTnIDVd
         59cg==
X-Gm-Message-State: APjAAAW6JNalN240d+GljxJdWInvvCouhc/mPlY2eIIzejZzOI3xrjEU
        Dj72H58sflVG/qtCb0w3aPBu+WS0fs8=
X-Google-Smtp-Source: APXvYqzOI70mfvwP6mAH/Dn+VfKEaAZCeT4o2iGW3Yb1b7m5/LEzVguaRPf3JSIOGAIIrx34dbPrVA==
X-Received: by 2002:a2e:970b:: with SMTP id r11mr22949227lji.56.1571178113487;
        Tue, 15 Oct 2019 15:21:53 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id m15sm5818991ljg.97.2019.10.15.15.21.53
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:21:53 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id n14so21855623ljj.10
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 15:21:53 -0700 (PDT)
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr23595993ljc.97.1571177667184;
 Tue, 15 Oct 2019 15:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
 <157117608708.15019.1998141309054662114.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117608708.15019.1998141309054662114.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 15:14:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiz1sHXu8SVZKEC2dup=r5JMrftPtEt6ff9Ea8dyH8yQ@mail.gmail.com>
Message-ID: <CAHk-=whiz1sHXu8SVZKEC2dup=r5JMrftPtEt6ff9Ea8dyH8yQ@mail.gmail.com>
Subject: Re: [RFC PATCH 02/21] Add a prelocked wake-up
To:     David Howells <dhowells@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 15, 2019 at 2:48 PM David Howells <dhowells@redhat.com> wrote:
>
> Add a wakeup call for a case whereby the caller already has the waitqueue
> spinlock held.

That naming is crazy.

We already have helper functions like this, and they are just called
"wake_up_locked()".

So the "prelocked" naming is just odd. Make it be
wake_up_interruptible_sync_poll_locked().

The helper function should likely be

  void __wake_up_locked_sync_key(struct wait_queue_head *wq_head,
unsigned int mode, void *key)
  {
        __wake_up_common(wq_head, mode, 1, WF_SYNC, key, NULL);
  }
  EXPORT_SYMBOL_GPL(__wake_up_locked_sync_key);

to match the other naming patterns there.

[ Unrelated ]

Looking at that mess of functions, I also wonder if we should try to
just remove the bookmark code again. It was cute, and it was useful,
but I think the problem with the page lock list may have been fixed by
commit 9a1ea439b16b ("mm: put_and_wait_on_page_locked() while page is
migrated") which avoids the retry condition with
migrate_page_move_mapping().

Tim/Kan? Do you have the problematic load still?

              Linus
