Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D5CC433E1
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 18:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D18622CE3
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 18:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DA+gEK7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgHFSjh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:39:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34616 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729234AbgHFSjg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 14:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596739171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSeGTx7DzZCh+sP0mMajVqXcmYXUD3jDyAI6XML2hko=;
        b=DA+gEK7caA5LZlZlH7Wffb3xW1+MIfnLYOGfolUUYfMhO6bdozEbq+tSUSuCGhhI1WT/q2
        xnLIa4iYQLdCOk2QBhh+J+D1LvmEkZcc2IqUZqORn1kJLu8ddu8SW4AjKFJp+pefVijVUJ
        5a7k1Kf635455DsUov3uRRvtK1qduA4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-wQ3CMy5TP3-oxFwd5_fqwA-1; Thu, 06 Aug 2020 14:39:30 -0400
X-MC-Unique: wQ3CMy5TP3-oxFwd5_fqwA-1
Received: by mail-wm1-f71.google.com with SMTP id a5so4443189wmj.5
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 11:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mSeGTx7DzZCh+sP0mMajVqXcmYXUD3jDyAI6XML2hko=;
        b=UatvnnJNjgnPRiI8whU1u2Ded45ZR4l/9Z403rqUuuQlyYzshRAJH4qZNRWAyWIyQD
         0wi9CLRlYuTVPLb1XSCZyT1Tuf3qYxdfzBh+yHpfvz9ruUsEAkdYbGz7+V4qkHvTzdqx
         kwKf1eYzO7wW9K1ornYKY51ahnXiuOw02NQaHCIXGOw3wy5UD5fpmL3dLPngMIt1v0jk
         3/h5uhgzy8HfXG5/5QIX2f5zBdLjTRz+qM5Pli0eLz+thv4v6npmkZDoJM7z6G0ugDCY
         4YxwEBTSeKmV7Ooe9dMGp/BPBKeMHFCKqaasPFxegN+ItalHGyutNLQMZgM5SC+/X5FG
         uZIQ==
X-Gm-Message-State: AOAM530/wurp5AuGHFos7A/IQ9l0KD6+JdBW3RuwbeJG9pQBUgqwLuZj
        c8qPEHWZ9IlOBnIMaRdMBNMdV0ekSTcpbN6GxGSenrqp4k4MqhA6OivESIB0UQ5gdmWA5CDUOwn
        xy60tHHa3LjSNWI+SICdu+l8=
X-Received: by 2002:a1c:bc54:: with SMTP id m81mr9727195wmf.73.1596739168866;
        Thu, 06 Aug 2020 11:39:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUZrnC7JvhFi591C7Uz5OezHi646AYsSyAdUcX1XYvfQOWZF/0xWpBypiyG+geNAY+DUqVLQ==
X-Received: by 2002:a1c:bc54:: with SMTP id m81mr9727179wmf.73.1596739168590;
        Thu, 06 Aug 2020 11:39:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20? ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
        by smtp.gmail.com with ESMTPSA id o124sm7576150wmb.2.2020.08.06.11.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 11:39:27 -0700 (PDT)
Subject: Re: [RFC 16/16] lpfc: vmid: Introducing vmid in io path.
To:     Tejun Heo <tj@kernel.org>
Cc:     Muneendra Kumar M <muneendra.kumar@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Ming Lei <tom.leiming@gmail.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
 <1596507196-27417-17-git-send-email-muneendra.kumar@broadcom.com>
 <61d2fd75-84ea-798b-aee9-b07957ac8f1b@suse.de>
 <08b9825b-6abb-c077-ac0d-bd63f10f2ac2@broadcom.com>
 <aa595605c2f776148e03a8e5dd69168a@mail.gmail.com>
 <20200806144135.GC4520@mtj.thefacebook.com>
 <96930d0f-cb4d-94f4-9cbb-c82d2f0c3840@redhat.com>
 <20200806144804.GD4520@mtj.thefacebook.com>
 <b7fb1e9a-49c4-f639-475a-791a195be46b@redhat.com>
 <20200806145901.GE4520@mtj.thefacebook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8850c528-725f-c89a-cdc6-a9abada80a69@redhat.com>
Date:   Thu, 6 Aug 2020 20:39:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200806145901.GE4520@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/08/20 16:59, Tejun Heo wrote:
>> If I understand correctly, your only objection is that you'd rather not
>> have it specified with a file under /sys/kernel/cgroup, and instead you
>> would prefer to have it implemented as a ioctl for a magic file
>> somewhere else in sysfs?  I don't think there is any precedent for this,
>> and I'm not even sure where that sysfs file would be.
> It just doesn't fit in the cgroupfs. I don't know where it should go for
> this specific case. That's for you guys to figure out. There are multiple
> precedences - e.g. how perf or bpf hooks into cgroup and others that I can't
> remember off the top of my head.

perf and bpf have file descriptors, system calls and data structures of
their own, here there is simply none: it's just an array of chars.  Can
you explain _why_ it doesn't fit in the cgroupfs?

Paolo

