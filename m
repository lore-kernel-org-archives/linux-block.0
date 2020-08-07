Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADABC433DF
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 11:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8337822CAE
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 11:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LssX8XYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgHGLiZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:38:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31898 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbgHGLiZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 07:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596800303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfOUJ4+BjltPAFti/b3iu3icgouccTaAdJUPLCrAOfE=;
        b=LssX8XYqR26mW5ymj++1G4A3zPToeZtIZvHyEYcGrvZlkJPWdviIsTSp1SrjbXrsozwg2z
        kokZWzZO3EaDcHkvQmjOnk8Llu5+duWdZQSyeAlS5IB86Nvj0Z1PNdNWZBpmFgmmaOX4+w
        AqjZorjojtLOBxTDV0nE0SwaOZwIDzw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-vA0oGTWiMt2Gll7pAS6xVw-1; Fri, 07 Aug 2020 07:38:21 -0400
X-MC-Unique: vA0oGTWiMt2Gll7pAS6xVw-1
Received: by mail-wm1-f71.google.com with SMTP id d22so706139wmd.2
        for <linux-block@vger.kernel.org>; Fri, 07 Aug 2020 04:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hfOUJ4+BjltPAFti/b3iu3icgouccTaAdJUPLCrAOfE=;
        b=eH8gXNMqlr0U2yhFWHn+bRvgTCwnf9Jcy97qhr/rKmuwUUxc05tljY/RaGV/6Wtshb
         YRo87x7IVaR1N01PJzpXsPiepQsQHT+/dsrWRWWbisQ2ZFo78L16fUcEvGUf4Vkof1ZR
         4gbMHoIbJLmPD+39KQIWhg16kflJ2OayMohNbOKZOFU6S+UpU+XMBDvUaRrCTHzOedUw
         fKa4wRvJ5RXaME7Ja85rfOiJ8Q/EaALLWMy9ujPsJeX2qkhghEEZonCFmnT9VVoJa0RS
         oPC5KT36PPX+CTy82t+sAi+j8VrXABuo6WaZCx5Q2L9WWCrxOeC3ecFaZEKr7H0V2cyg
         pjdw==
X-Gm-Message-State: AOAM532gNmOOQtjF4Sze/CfbgaR+i3dQTTq2K5zJ6gt1awCVhqcnRQeR
        EAyltbcDx4xUGNnbxeNx16ubW+LJleuwONpN6jZKlTER3KLBJ6Vls3BBNzg1g6nFUeW3U7D8Dyi
        KMJKYC2kljjiFR2gOKqIBI+M=
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr11706006wrw.365.1596800299862;
        Fri, 07 Aug 2020 04:38:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxXfjgfX/uG+oj/WhrgTowvm75Rk1DP4r7Cyk1R7HADrjfolz6Xc8MHFV6zkexd3GG5/fAgA==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr11705989wrw.365.1596800299648;
        Fri, 07 Aug 2020 04:38:19 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
        by smtp.gmail.com with ESMTPSA id g3sm11317635wrb.59.2020.08.07.04.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 04:38:19 -0700 (PDT)
Subject: Re: [RFC 16/16] lpfc: vmid: Introducing vmid in io path.
To:     Muneendra Kumar M <muneendra.kumar@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Ming Lei <tom.leiming@gmail.com>, Tejun Heo <tj@kernel.org>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
 <1596507196-27417-17-git-send-email-muneendra.kumar@broadcom.com>
 <61d2fd75-84ea-798b-aee9-b07957ac8f1b@suse.de>
 <08b9825b-6abb-c077-ac0d-bd63f10f2ac2@broadcom.com>
 <aa595605c2f776148e03a8e5dd69168a@mail.gmail.com>
 <227c5ba1-8a9c-3ec9-5a0f-662a4736c66f@redhat.com>
 <b3350b999d5500ddef49a25aafee2ea6@mail.gmail.com>
 <eec84df0-1cee-e386-c18e-73ac8e0b89a3@redhat.com>
 <e76b12c664057adb51c14bf0663bb2f7@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b471b84f-25e9-39cb-41e0-1cc1af409a8a@redhat.com>
Date:   Fri, 7 Aug 2020 13:38:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e76b12c664057adb51c14bf0663bb2f7@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/08/20 13:24, Muneendra Kumar M wrote:
> Hi Paolo,
> Below are my replies.
> 
>>> 3.As part of this interface user/deamon will provide the details of
>>> VM such as UUID,PID on VM creation to the transport .
>>> The VM process, or the container process, is likely to be
>>> unprivileged and cannot obtain the permissions needed to do this;
>>> therefore, you need to cope with the situation where there is no PID
>>> yet in the cgroup, because the tool >that created the VM or container
>>> might be initializing the cgroup, but it might not have started the
>>> VM yet.  In that case there would be no PID.
>>
>> Agreed.A
>> small doubt. If the VM is started (running)then we can have the PID and
>> we
>> can use the  PID?
>> Yes, but it's too late when the VM is started.  In general there's no
>> requirement that a cgroup is setup shortly before it is populated.
>
> This should be ok .
>
> The fabric  interface just provides a mechanism to store user
> specific data into a pid blkcg
>
> Before the daemon issues the UUID and pid to the fabric interface, it needs
> to check whether the VM is in running state or not.
>
> If it the VM is in running state then only it issues the VM details.
>
> And if the  cgroup's are not setup as you mentioned the interface will
> return a failure(with a proper logs) and the daemon will retry after some
> time.
>
> And this also helps us to keep track of PID to UUID mapping at daemon level.

Why would that be useful?  Again, the mapping of the UUID is _not_ to a
PID, it is to a cgroup.  There is no concept of a VM PID; you could
legitimately have I/O in a separate process than say the QEMU process,
and that I/O process could legitimately reside in a separate blkcg than
QEMU.

There is no need for any daemon, and I'm not even sure which daemon
would be handling this.  App identifier should be purely a kernel
concept with no userspace state.

Paolo

