Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7F9C433E1
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254292312C
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUxt2KmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgHFRP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:15:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34200 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729896AbgHFRPL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Aug 2020 13:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596734110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0c1/Bp7ocDdt7QI3/o/M8hE809LAqDVMjlZbaureeIM=;
        b=MUxt2KmEqXpvd6ncfRMp2Kv1m9LTf/JkaBfZZW37HhPy8CwDHOhk2zSVFWSgYiVwU19e5B
        OY+jMlkA0u2jiDbi42sMvybXSFop1ttGV5yiRWAhAm+OMTZy6LN5mePrmiJmaO+UI3v9+K
        VSiDsNDaqZRms1W3F5v6blbGVBEi19Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-OR31QS8OMVSaJ1Xyn0I3rA-1; Thu, 06 Aug 2020 10:46:48 -0400
X-MC-Unique: OR31QS8OMVSaJ1Xyn0I3rA-1
Received: by mail-wr1-f70.google.com with SMTP id b13so12174082wrq.19
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 07:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0c1/Bp7ocDdt7QI3/o/M8hE809LAqDVMjlZbaureeIM=;
        b=kmmUCeBFHfysaaT4ULyixtX09f+oRaHhw3HcUu+nW4ChMI1dqoOcK0JU0wSMXy+EWs
         MWCuRB4L1OrF+SZSQt9UhT5vyknqGzqMuBCsHBm7QCfiLNEYEPXCBLL6kmk/TEVnSPCu
         E+IHgw8KQaTKDoDH6amS05YshVonz+0vJ0eUxIs5omniUV9Qt2y0AX9nwTm62bU7nqzk
         xb/rSJqJZNZsarOKpCNreS9txympiGXdg3gequhUnvMHs8/CkZ4P7lmNeDj49/MF48j0
         f9jAeaV7Wzj0DDLVIFh02plSteL9zTLtVbZ2jbNal+2S/rsboNAIlPgyOdPVSku1C9AI
         MydA==
X-Gm-Message-State: AOAM531PgEWfvNdtqD/g0ShJfYqC+ySKUL8Bh8yky8G3Sq9yrbkmBRZr
        cX9jGM4h5qOGfZjAla0llcnr2gT3Ztc8O4jAebnWOIRA/ZFOoN8YUgzOfo9TPcU89h22XMHh/b+
        XNppEDTvJBrrB32UI0MfSquA=
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr8442423wmk.153.1596725207728;
        Thu, 06 Aug 2020 07:46:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylL3roPS5v+IqXA0mUMSU8r5ytNbRCIB5DavoUedvjg0VapQysCXkty8XEJjSczhb154Tyvg==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr8442408wmk.153.1596725207529;
        Thu, 06 Aug 2020 07:46:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20? ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
        by smtp.gmail.com with ESMTPSA id a22sm6461054wmb.4.2020.08.06.07.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 07:46:47 -0700 (PDT)
Subject: Re: [RFC 16/16] lpfc: vmid: Introducing vmid in io path.
To:     Tejun Heo <tj@kernel.org>,
        Muneendra Kumar M <muneendra.kumar@broadcom.com>
Cc:     James Smart <james.smart@broadcom.com>,
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <96930d0f-cb4d-94f4-9cbb-c82d2f0c3840@redhat.com>
Date:   Thu, 6 Aug 2020 16:46:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200806144135.GC4520@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/08/20 16:41, Tejun Heo wrote:
>> 1)	blkcg will have a new field to store driver specific information as
>> "blkio_cg_ priv_data"(in the current patch it is app_identifier) as Tejun
>> said he doesn’t mind cgroup data structs carrying extra bits for stuff.
> 
> I'd make it something more specific - lpfc_app_id or something along that
> line.

Note that there will be support in other drivers in all likelihood.

Paolo

