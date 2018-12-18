Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65427C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4C02133F
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeLRH0n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:26:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45172 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRH0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 02:26:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so14572781wrr.12;
        Mon, 17 Dec 2018 23:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=CYQ60O0+/Yd71SkdGShmQ1fDYxQvIdErVIamIhAuUJVxpdJ96ARl9RxHuWd5vsJLBC
         8SvFdv3alfdsnn92JMm/0NZ+uWq3JvWC4aBKc2BJYXjM0CLrR9+3chzz2NzuV6s256n3
         pba69B9oNBrsBYbuzeRXEABpjlm4+uBc64hdgmXvZHQGwR6Rc1P/wDxMZedBhGE84hIy
         iHeCN9NocvW/ge/nZCWtvQkaiEcJhsDcmv1fN+OEgI7kDalHwnPi4cPKHw4YDWV0CWte
         wIfhycYkUpCphOj2f1vjmMpeSYYhi6O8u2QmDKziZUJaqygQ6ljwoNbKfoykEJAO6Ecv
         Qwpw==
X-Gm-Message-State: AA+aEWaBAFD5a3U0Mm2a4ON81njbvbk6BG10NhZpmhI2R9i0BJj+/h7F
        jnm3hphgXC8LpdmtZ18u8yM=
X-Google-Smtp-Source: AFSGD/UpEzlc/qTt0XcJbblJAj/NnVlLGller6I6SKfUl1TxutvRwUjnURxcaAr1Aw+QleO/9q4ecw==
X-Received: by 2002:a5d:49cd:: with SMTP id t13mr13599972wrs.144.1545118001822;
        Mon, 17 Dec 2018 23:26:41 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:104e:891:8425:41e? ([2601:647:4800:973f:104e:891:8425:41e])
        by smtp.gmail.com with ESMTPSA id a1sm1979255wrw.76.2018.12.17.23.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 23:26:41 -0800 (PST)
Subject: Re: [PATCH v4 1/2] export trace.c helper functions to other modules
To:     yupeng <yupeng0921@gmail.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, axboe@fb.com, hch@lst.de, jthumshirn@suse.de
References: <20181218045138.4282-1-yupeng0921@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f09c62c8-5997-e507-c0e1-8ae41cbc205b@grimberg.me>
Date:   Mon, 17 Dec 2018 23:26:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218045138.4282-1-yupeng0921@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
