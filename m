Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72CEC433FE
	for <linux-block@archiver.kernel.org>; Fri,  8 Oct 2021 11:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BF961040
	for <linux-block@archiver.kernel.org>; Fri,  8 Oct 2021 11:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240122AbhJHLND (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Oct 2021 07:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231979AbhJHLNC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Oct 2021 07:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633691466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=beL+lHu4Yb6ST/YHe2oKhpNvDASDezmXv1HiQU4m3Qg=;
        b=SA248/MngBr4V+O4KWXJhqYVAUc4QN6L4IzeVRGNsOinXZY7NS/54RammEPuqkQj98XsgB
        s6ZNGsLjzAmIZkpjPmujpceUykyOnunkF0fMUSor4xJaGv8r0FEqnK7WRg3Am9LwtbT9V9
        RmUVp+w3AHvi9PXJfmic+i2yr+iK6Io=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-A0ME8I3YNxyT4Vm51BKK9w-1; Fri, 08 Oct 2021 07:11:05 -0400
X-MC-Unique: A0ME8I3YNxyT4Vm51BKK9w-1
Received: by mail-wr1-f72.google.com with SMTP id c4-20020a5d6cc4000000b00160edc8bb28so1242064wrc.9
        for <linux-block@vger.kernel.org>; Fri, 08 Oct 2021 04:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=beL+lHu4Yb6ST/YHe2oKhpNvDASDezmXv1HiQU4m3Qg=;
        b=fGoh2eFh5hcw04kuahUvvRr/Ey/3VsMMMx2Z3hjQAyqgW4cD1dL1+Ywg7KSO3LxXYa
         4hjFnY4Uiy3vPHtQdQdLDKToVdGx7W3KW1BRBmP/XePluXOoDTnDcfYyOsbQ0N/d+RdI
         lMgEJ/Vx+VGA5h7fwmz82P7L4zGGu08fLQKlbZ+8vdg8gMoFIUmlx+8U6InLOECrG2bH
         wiCxYnBytrL+mCUlpe9RUu9LoczxueBOHJGPHnhlCuMxu96AhtqghXkaELim3ArIgQa6
         LJMF7OktZ3hkJ0GHTmy9PsgXjZXXvZazHYRITUeV5fI+ASGq0b+kQxbr1CURqP86g1c3
         3G0w==
X-Gm-Message-State: AOAM533aFhhvKh+xVOcphAX/2YNhpu5uhs5vPTzc48S7u5bsOI3LL0u8
        CzLFgzG+XoYMoIxLH5R2DoBQkQveQSbUx/dMS6Imzi+Y5H+m5bp5siy7/vWop/A9PVjW0EP5z6z
        KbsnFIgR3nnw0bAbOGR/YlgE=
X-Received: by 2002:a7b:cb4b:: with SMTP id v11mr2775636wmj.155.1633691464373;
        Fri, 08 Oct 2021 04:11:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJWz/YVYFIIpOplJfuo/FOI1MaHjPWY2n3Z2/U3ORFID7I1ioP6msn33W2JQQwEvNs6r+RHQ==
X-Received: by 2002:a7b:cb4b:: with SMTP id v11mr2775600wmj.155.1633691464206;
        Fri, 08 Oct 2021 04:11:04 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z12sm780472wmk.38.2021.10.08.04.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 04:11:03 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Long Li <longli@microsoft.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
In-Reply-To: <YV/dMdcmADXH/+k2@kroah.com>
References: <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
 <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
 <YVa6dtvt/BaajmmK@kroah.com>
 <BY5PR21MB15060E0A4AC1F6335A08EAB4CEB19@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YV/dMdcmADXH/+k2@kroah.com>
Date:   Fri, 08 Oct 2021 13:11:02 +0200
Message-ID: <87fstb3h6h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

...
>
> Not to mention the whole crazy idea of "let's implement our REST api
> that used to go over a network connection over an ioctl instead!"
> That's the main problem that you need to push back on here.
>
> What is forcing you to put all of this into the kernel in the first
> place?  What's wrong with the userspace network connection/protocol that
> you have today?
>
> Does this mean that we now have to implement all REST apis that people
> dream up as ioctl interfaces over a hyperv transport?  That would be
> insane.

As far as I understand, the purpose of the driver is to replace a "slow"
network connection to API endpoint with a "fast" transport over
Vmbus. So what if instead of implementing this new driver we just use
Hyper-V Vsock and move API endpoint to the host?

-- 
Vitaly

