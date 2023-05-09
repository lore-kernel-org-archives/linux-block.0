Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089C1C77B7C
	for <linux-block@archiver.kernel.org>; Tue,  9 May 2023 06:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbjEIGdx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 May 2023 02:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEIGdw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 May 2023 02:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2D593C1
        for <linux-block@vger.kernel.org>; Mon,  8 May 2023 23:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683613993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/p29a3jU9JdsGK+jRm1PlnpUc4nPIekff1IWLWwyo7I=;
        b=DDhR6lcyIonY0KOVKhbedrFpX9EzTeXbrlkXeCLIPGF+BcF9yWVo08DeX+gxNqNKeMWvpz
        uTVct+Ebhwbp3Dej6/YEEsHpJ/aHzOFD+lFuo3SBn04Xklug6o84QaztJDMqtoRftKOun0
        ESPnFcVdWfvLNNDr2oGiLJijbMBiau8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-0ULCbEkuN6eBUGShYn9eKg-1; Tue, 09 May 2023 02:33:11 -0400
X-MC-Unique: 0ULCbEkuN6eBUGShYn9eKg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-61b59e13fbeso62667506d6.0
        for <linux-block@vger.kernel.org>; Mon, 08 May 2023 23:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683613991; x=1686205991;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/p29a3jU9JdsGK+jRm1PlnpUc4nPIekff1IWLWwyo7I=;
        b=P33+1dV2ASZ9i/QwTP5tYN5HWxVXNQmFredqQwPxpKMWHpLuxBbw7++JfdMKEWU6Wd
         5CW88mRN2PUsj8V2GCEtRGxAywWfIKIVFmuwdrbPvH07CEUYsYYabiiff3kT0TZ9RVmc
         m6cDP/Kk6QiZkqLwbFFKoYqR69TWqMgrSaSm4lxnhu75/E3k1DlSRfDo0elwggnqeeoJ
         nkUDA06Moy2+dPt0Y4ublbSAsxg0ZmA8ZhkMkn4HQvRBxFI73iSDOhispRofHShpCdF4
         mHybY9z0jnA/AqJm8LScc5mBCeg6+awCPgQvlG4dcSA3eskFx521KYfGDWcjNAOnfLcl
         aqqA==
X-Gm-Message-State: AC+VfDxfWKtlJmtXVmuOhvXpK8aLe+wsTjpNX4gjv3aau4GwwAvZpD6p
        vNxeM03VVAp7AbUMrTMP6KNOMIhlJsMo70mDbi4xuzMI4LgQp+l4w+J41bBTh+oCwf6emqQ1yNx
        JmUabPBBS0/FCETMgGGgGSzm74IQvyxtHqg==
X-Received: by 2002:ad4:5cae:0:b0:61b:5dd6:1f26 with SMTP id q14-20020ad45cae000000b0061b5dd61f26mr18526771qvh.28.1683613991099;
        Mon, 08 May 2023 23:33:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6XTJDHYYoXNMwBQKCiFZQoIaDirG8uP4BdmF62WfXy4/6qETYvr6Rz9yzJR49oV0rV3PZ+CQ==
X-Received: by 2002:ad4:5cae:0:b0:61b:5dd6:1f26 with SMTP id q14-20020ad45cae000000b0061b5dd61f26mr18526762qvh.28.1683613990858;
        Mon, 08 May 2023 23:33:10 -0700 (PDT)
Received: from [172.16.2.39] (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id nd2-20020a056214420200b0061b5b399d1csm533820qvb.104.2023.05.08.23.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 23:33:10 -0700 (PDT)
Message-ID: <e6deef8f-4e0e-3b62-b7c7-1a85dc10f0d5@redhat.com>
Date:   Tue, 9 May 2023 02:33:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH 0/5] Add the dm-vdo deduplication and compression device
 mapper target.
Content-Language: en-US
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
References: <20230509010545.72448-1-corwin@redhat.com>
Cc:     "vdo-devel@redhat.com" <vdo-devel@redhat.com>
From:   corwin <corwin@redhat.com>
In-Reply-To: <20230509010545.72448-1-corwin@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It seems that two of the patches in this set are too large as they 
stand. We will divide them up and resubmit a new version,

Thank you for your understanding and forbearance,

corwin

