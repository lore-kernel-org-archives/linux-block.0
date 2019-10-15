Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940E4ECE58F
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 22:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AE12064A
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 22:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571178750;
	bh=ZZ1tkLH6Evl6gaSnOj/4I8fnnuCBE15LMoxDF1dxmkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RPS11JQiM5ODIQa9rZbDRZFtTxbbwCtHQ3r2asQZ/EHl9XyCqAlVlej4arerAPe7r
	 iJPOE8w+IMX9hZrLpyWwux/MlYbox6FjV1BTk9z4fsc3nCNQa4LiIeo47RRHbWql3i
	 BnJWsCWjwDlHCthBLu1+yJ1Ku8oqzCVJa/ZHW68g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbfJOWc3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:32:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33531 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbfJOWc3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 18:32:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so21927076ljd.0
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 15:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fon9Xqueqx/Fq0wGHnHqEDUCXyflZLUwsevU6fmx6jE=;
        b=SIEI+eyzsLvgKQSWy68fNU4waAO3JnvS6nzHr5/fZu5+F3lS+ninFSB5dUKCVryHZ+
         kl8H8QJRcmYfRoBpcYQdlcvyFYmbnE5AhMRuYRji7sgqsBgEDlqfBvGU7GUQWJu2UMf7
         6W/csLC8ZHTI+HN72RKiuRYhkxOOMexsvDhzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fon9Xqueqx/Fq0wGHnHqEDUCXyflZLUwsevU6fmx6jE=;
        b=TWKlJZo6onp82W0ka6uVVfQFZOTq13Z49d5wFYrxO7B0txfXlfCQzF4VxKkoA0wMQ9
         DrSuQ1nFe6yW5XszBjfEvIUMIeIAU+He7HXK7iKT9empVR1m7e4MRvBuekC0yx0zLqxk
         2FgfHHAPlznPia5IZG3v6+XtzHOPAUX6JpE/PsH/jV+YaqYQCHqwbG+HXEnOEiYreZVl
         cq8O8c9V3J1mrwvqGuUitCEM4Q2Mq2X9G4Z3fmVf0fofctzIeNaNuEdIqp+cCtaS3WO+
         RB+hPj+s4ZLp/cou+zKiP8FrthXVWUX/8ZjeTVYodwVsTJZ0h+Ry1rGpjAFnkQ6H9cMy
         KKxw==
X-Gm-Message-State: APjAAAVA8cmTOROMR+oZh5B09RnD05hB2XY4xgN1GBwFmHtWgWQYjxau
        cbwp098LxYHg0De1qrDoh3ffEMVp820=
X-Google-Smtp-Source: APXvYqxwOcn92wfzzL1KSwP6nHpCZRjTJtMu8SSgha7WLaN6znw8d4MbjSC4ocdAr9UhdivpmMtFug==
X-Received: by 2002:a2e:957:: with SMTP id 84mr23438695ljj.245.1571178746588;
        Tue, 15 Oct 2019 15:32:26 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id c4sm5227860lfm.4.2019.10.15.15.32.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:32:25 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id r2so15718788lfn.8
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 15:32:24 -0700 (PDT)
X-Received: by 2002:a19:5504:: with SMTP id n4mr4230778lfe.106.1571178744104;
 Tue, 15 Oct 2019 15:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 15:32:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfCy+WCZ5SXZGi4QEhxXm=EjZjj4R9+o4q-QR3saMyfg@mail.gmail.com>
Message-ID: <CAHk-=whfCy+WCZ5SXZGi4QEhxXm=EjZjj4R9+o4q-QR3saMyfg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] pipe: Keyrings, Block and USB notifications
To:     David Howells <dhowells@redhat.com>
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

Aside from the two small comments, the pipe side looked reasonable,
but I stopped looking when the patches moved on to the notificaiton
part, and maybe I missed something in the earlier ones too.

Which does bring me to the meat of this email: can we please keep the
pipe cleanups and prepwork (and benchmarking) as a separate patch
series? I'd like that to be done separately from the notification
code, since it's re-organization and cleanup - while the eventual goal
is to be able to add messages to the pipe atomically, I think the
series makes sense (and should make sense) on its own.

          Linus
