Return-Path: <SRS0=wHaM=BW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE0DC433DF
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 07:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DC220771
	for <linux-block@archiver.kernel.org>; Wed, 12 Aug 2020 07:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsRL+DWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgHLHzF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:55:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22400 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726517AbgHLHzF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 03:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597218903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xY9VAJC472MZ84jB/ysIkzHjZyedHuX8r0oc6/8O0pg=;
        b=dsRL+DWbOtd1m6NXuMTXDZErPvMnsvKMLOymbZQrclrNZV4AZ1V7z2Hczal9LnIJP9Idxi
        9RVWwYolIyUEKRGbdH5OEzyDlYlDQWUog/eRK+7tCf8iuiJ36iUhr1aCaW3yMbFtwpzb3e
        B7JaEwIH5uLL/UnlPGLA/WdagL/g/8A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-qOnfRgAbMbicjkNqJOjQ4Q-1; Wed, 12 Aug 2020 03:55:02 -0400
X-MC-Unique: qOnfRgAbMbicjkNqJOjQ4Q-1
Received: by mail-wm1-f70.google.com with SMTP id i15so420166wmb.5
        for <linux-block@vger.kernel.org>; Wed, 12 Aug 2020 00:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xY9VAJC472MZ84jB/ysIkzHjZyedHuX8r0oc6/8O0pg=;
        b=qst23Zvt2GKGSZyUvUoMmtsZk5bijySs+9NVkO4zukAJoQiIFtMrLs/0xFJt9Qc58k
         OaYm6FR4sX0lVClq1wpohcLBDHzhDjbpUidqhWScL8PsyjhAlPbTeyK8pmnZ0pDlhW11
         MjoLonZiPeoWmXWb4RSrlk8la/dElEpCAzAdOH5gwE7EYduXVCNFH+CWrSW23Hj37sMV
         do2uIzUa7/lxF3jRifcFISfgwvHHELnbpECfXUgB2zUf0g8SpHGR0FRVwMviDOLgV/23
         YY3wi6bgXf09crbi3Zx8fUKz23ACyKXP5Tkt5n8Kc7dgRlBMQGo2s/YGhfAkNWkf5Omr
         Q9DQ==
X-Gm-Message-State: AOAM530KPaOnxoYX9urca3MePSkLJcyzmKEyaO0Dbng/qXlWo++4ESCc
        8hVxmuMidfiG09ibBLUu6hnX2rlZD6yWYauKEqh/kOYZS0dm9eu4TEG65a6j6qXHnhLW0HA7Gwq
        BGXCdBexCownIteSn9lMLG5M=
X-Received: by 2002:a7b:c20a:: with SMTP id x10mr7879292wmi.177.1597218900852;
        Wed, 12 Aug 2020 00:55:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ2SjVvy1bk2zoDKzfrj1gE+bf7p0R5mE7XoymuLG6NMkxhtVnk7+oOgEcMMtqGZVf9zDwVA==
X-Received: by 2002:a7b:c20a:: with SMTP id x10mr7879264wmi.177.1597218900560;
        Wed, 12 Aug 2020 00:55:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:744e:cb44:4103:26d3? ([2001:b07:6468:f312:744e:cb44:4103:26d3])
        by smtp.gmail.com with ESMTPSA id h10sm2612050wro.57.2020.08.12.00.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 00:54:59 -0700 (PDT)
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
 <b471b84f-25e9-39cb-41e0-1cc1af409a8a@redhat.com>
 <7e76e1464e794a79861ea9846e0a5370@mail.gmail.com>
 <053466c4-7786-38aa-012f-926b68c85c8c@redhat.com>
 <05697e72c1981838c5471e503b28dfc2@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4bf914b-c0ff-5876-890d-f1889308f6ea@redhat.com>
Date:   Wed, 12 Aug 2020 09:54:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <05697e72c1981838c5471e503b28dfc2@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/08/20 14:13, Muneendra Kumar M wrote:
> Agreed:
> So from the user we need to provide UUID and the cgroup associated info with
> VM to the kernel interface. Is this correct?

Yes.

> There is no issues with UUID  passing as one of the arg.
> Coming to the other cgroup associated VM here are the options which we can
> send
> 
> 1)openfd:
> We need a utility which opens the cgroup path and pass the fd details to the
> interface.
> And we can use the cgroup_get_from_fd() utility to get the associated cgroup
> in the kernel.
> Dependent on utilty.

This looks good to me.

Paolo

