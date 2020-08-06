Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07FCC433DF
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B9223119
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpMPoF8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgHFRSt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:18:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38830 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730398AbgHFRSD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 13:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596734281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c62S3FDTWB5DNi2bOV+bb/p0i2olIR+ZCvofXOklb84=;
        b=ZpMPoF8niP9S60gwa+E5AMO22tX+bgkm2her7dqWgneT9mKAZmeC/VG22NW44lF/LJiQSs
        Cqr9kHok792Jx8qMaZtQTq7eXXnoqB4Ux8C8VNJ6utk56J5/dJkN3jCZfZknP3m3jRCfOJ
        ZeVnlYa2KsI4DPT/1uorAF6OQTU9zi8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-L0YauFByNsm23eyubCF5PQ-1; Thu, 06 Aug 2020 10:54:24 -0400
X-MC-Unique: L0YauFByNsm23eyubCF5PQ-1
Received: by mail-wm1-f71.google.com with SMTP id s4so3720382wmh.1
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 07:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c62S3FDTWB5DNi2bOV+bb/p0i2olIR+ZCvofXOklb84=;
        b=PUYSmkJY97OZXocu1y/TvSeYbfNwPOuK4tnQeZWTfgPacZPLWnCDJ28pQXWUyukjPo
         bkpUO3FSMIERRq8U7cA/lNUcnjzNtO0ndFtGTIsfk4Mnem4oufSN8gQ+Jc+sN0Sc8q9x
         0lhDqci7/MfMs9XtQfZVO+3hzMZeI9HjY/J6t/Dexb3X56PkZ+P9PryY4bw/R8D7frgU
         +uhhJUcGF4aXDm1NJuNsPJxYlk80izfMpgUo6yP3LHec+mcsyiT0YHtXMbBLfHK+G65d
         Ou1nrO1++J78xHfM0t4Mi57ViQhAq+O73hYI44GRAAEf2oSQGIW4mIJSv66dP4vAf5uI
         Ywow==
X-Gm-Message-State: AOAM533d0CnCA0PGQ8+Kst6kpjzALvgroNMk05iWgat4YhWiz12b51pz
        Ir5oTZBhfDJoAJXPIo42BklEcBwDY2+WiUQ7cc7+FWVNX+G/dNt/6vm/5VfJY+W9dYZkWM3crL7
        WTPQ2vYv/a9C+3njQZk7pTIU=
X-Received: by 2002:a05:6000:12c1:: with SMTP id l1mr7411128wrx.270.1596725663034;
        Thu, 06 Aug 2020 07:54:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD+D3J81jrieJNsTVbB0yypLvKEuKreAdqQ1W1MwebvzezGKzsMF5xpnsIr3VQgks1ctNfaA==
X-Received: by 2002:a05:6000:12c1:: with SMTP id l1mr7411105wrx.270.1596725662738;
        Thu, 06 Aug 2020 07:54:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20? ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
        by smtp.gmail.com with ESMTPSA id k15sm6939002wrp.43.2020.08.06.07.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 07:54:22 -0700 (PDT)
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b7fb1e9a-49c4-f639-475a-791a195be46b@redhat.com>
Date:   Thu, 6 Aug 2020 16:54:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200806144804.GD4520@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/08/20 16:48, Tejun Heo wrote:
>>> I'd make it something more specific - lpfc_app_id or something along that
>>> line.
>> Note that there will be support in other drivers in all likelihood.
> Yeah, make it specific to the scope, whatever that may be. Just avoid names
> like priv which doesn't indicate anything about the scope or usage.

So I guess fc_app_id.

If I understand correctly, your only objection is that you'd rather not
have it specified with a file under /sys/kernel/cgroup, and instead you
would prefer to have it implemented as a ioctl for a magic file
somewhere else in sysfs?  I don't think there is any precedent for this,
and I'm not even sure where that sysfs file would be.

Paolo

