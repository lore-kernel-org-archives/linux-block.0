Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28100C7EE2F
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 08:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCCIwT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Mar 2023 03:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCCIwS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Mar 2023 03:52:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1F04E5C4
        for <linux-block@vger.kernel.org>; Fri,  3 Mar 2023 00:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677833488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ygl23er0UDQlPMwv+4NA+1c1Ld1E0uoRapwxOwJTFn4=;
        b=KjfIwRf1OpaXDn95XdWJ0gDi8CixRiS7KhOgogsLykCryEvXhXsACs+bQA3yijmjO1CV1z
        kCR2pNPGY99KaOK1XPg2QfpMW9oK334cxKWu0n+hwAwgzmodC3ATniVN48r2ViMyqPNG3L
        6qJXsE1QsC7ywtH/HJVo9tkjge16MG4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-499-KhY6S-WdPCyb2OVRhyfWvg-1; Fri, 03 Mar 2023 03:51:27 -0500
X-MC-Unique: KhY6S-WdPCyb2OVRhyfWvg-1
Received: by mail-pf1-f197.google.com with SMTP id a10-20020a056a000c8a00b005fc6b117942so1044583pfv.2
        for <linux-block@vger.kernel.org>; Fri, 03 Mar 2023 00:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677833486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygl23er0UDQlPMwv+4NA+1c1Ld1E0uoRapwxOwJTFn4=;
        b=d//jEvgiNK8vXgorFknbX64N8K2ea93H60wLP8+JSOsEeWFJ/0lc4egDLTu1129b2h
         RTRCKJSdvfzHkH1+kI/bYrqSm9/SGX6tTmxlscUF2MQhxRF6YymxEonfzpV5Jjve+OlL
         5PeRL3WUpj1lPHHSpFd0K7XLB7LTOPvVnDu+e86+BZ8jdt8MRsMrO2DYcPW5SXEfLDtf
         6ais+F5LU64y/cxCZJV2vmBSht/ewzdWTqiAmnRUY8ufkfFu5je5PGKN1I5DyhJBpgNA
         EoFahEZQymfgRQ0RufLdCXMtbE1XHitvBu6MOuZd+PEfbx9rTYS4OEiOV5Wp818VS7O9
         UuDg==
X-Gm-Message-State: AO0yUKVHBvUNMlwhy/z4ghWixXH3S1VOnYX4u2EOjhnLb5LjKihu7HcK
        4LY+mp85zIm+3WDjortgjVJMY7hjjDm5BdKa+es+axQ2kAfQvdnc0Y+Qeok3vxod0YSJGa3tzgG
        QUOYDwvE1fJW+BWA3cBFnc6p4k/7Iu5Z1+eTXo61St3EnRX1j4w==
X-Received: by 2002:a17:90a:bb8d:b0:234:b23:eade with SMTP id v13-20020a17090abb8d00b002340b23eademr298652pjr.9.1677833485951;
        Fri, 03 Mar 2023 00:51:25 -0800 (PST)
X-Google-Smtp-Source: AK7set/clTNL9t3RBSYlBYXclm4rQ7I44QJSdQM32XbSm8+qDeECH9GzVPO1css0VVs7MzhGy4XeljVOk3DnN1HN36k=
X-Received: by 2002:a17:90a:bb8d:b0:234:b23:eade with SMTP id
 v13-20020a17090abb8d00b002340b23eademr298641pjr.9.1677833485672; Fri, 03 Mar
 2023 00:51:25 -0800 (PST)
MIME-Version: 1.0
References: <CALTww28pEdW+f1SaXrG7Umf8uA6fAc9io-WKb_W8mVxEzW8EzA@mail.gmail.com>
 <ZAFhRj8YVpiO3b5g@T590>
In-Reply-To: <ZAFhRj8YVpiO3b5g@T590>
From:   Xiao Ni <xni@redhat.com>
Date:   Fri, 3 Mar 2023 16:51:14 +0800
Message-ID: <CALTww28i3W6dsGAmgYgGKSpJMMA_ci-hZs_EERr+1BBiyE-vsw@mail.gmail.com>
Subject: Re: The gendisk of raid can't be released
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org, Nigel Croxon <ncroxon@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 3, 2023 at 10:54=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Mar 02, 2023 at 11:51:59PM +0800, Xiao Ni wrote:
> > Hi Christoph
> >
> > There is a regression problem which is introduced by 84d7d462b16d
> > (blk-cgroup: pin the gendisk in struct blkcg_gq).
>
> The above commit has been reverted, can you test the latest linus tree?
>
>
> Thanks,
> Ming
>

Thanks for the information. I have tried with the latest linux-next version=
. The
problem doesn't appear anymore.

Best regards
Xiao

