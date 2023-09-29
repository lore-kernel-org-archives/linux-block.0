Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09013E81810
	for <linux-block@archiver.kernel.org>; Fri, 29 Sep 2023 12:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjI2MMF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Sep 2023 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjI2MMF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Sep 2023 08:12:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310D0193
        for <linux-block@vger.kernel.org>; Fri, 29 Sep 2023 05:12:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c724577e1fso40843185ad.0
        for <linux-block@vger.kernel.org>; Fri, 29 Sep 2023 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695989522; x=1696594322; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL45IqGKFINeZXD3V3WGPUqTF0v8lHv/e4pLArJn4Hc=;
        b=RInZKyWhPBIUBb938RNJ9W3Fo3FpBNYlP0N5T9ETfGirDy6gre/mWKswg2ed/dSIXu
         Bnm4m18F520IuBMcixDcFQ/a747+alaxA39Uz+bzHJpqDNCRUb/BxvDsG4JsSIsojleD
         W33fLoOcmEGPnvuxjhBD0hTdj+LftzvMVRiB3PQ5D8eKwMBxd4BBayKuXxdJg+gSHXXT
         03oFqNw/utI4Uov8Ow6kTe87txg+dqIBNIgtSCur6jZGEUrZRD4xpElflrTBoHhTN4b6
         DxBvisTkOKd0of67sEC7QxQXRVFJiPtE+plZBAi3Xb1XZsAkaVsqFvJDdl73L/WbRssP
         F8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695989522; x=1696594322;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:to:from:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dL45IqGKFINeZXD3V3WGPUqTF0v8lHv/e4pLArJn4Hc=;
        b=SzUn5rX/x6GZL4vECWJUut1KG+mJ9G7nrKlLfLmlJEZRMkEQfmbFvXHDU0J7MbWJci
         kAemaCwRfH0NlKJ4Gmx1r0/L0TC/Ypq7xgGMT3qU8Z7F7qEVar5bIRAYoHx8ouxbeqaS
         leBn/rLAH7eV4MEb4F7rmQGXwfCnANDByJW1Hagy+oR75SjL173/8lLMcrs3YmJLgpnD
         cCq8+Gj26YzRegCX7NrRER2qxFlDkGz7SrFnHF68NQ/OyJSSerjlpz9gFNCUZClWxmxS
         MLYYJheL24m79ykT74cO735jwDcA3xXEjNwOHkHsB8I4zogqfNj/3B4NtRNIDpTo1m5b
         9mPQ==
X-Gm-Message-State: AOJu0YwbEk9WXRCcp8eMPqabduCIs7l9BuL4Uw624ucjVC7NuXlHn1FI
        iZNgxuMQN3RrFQdK631fpJ2P2luXZsI=
X-Google-Smtp-Source: AGHT+IGOb9nWvy0muszNhwvyXU7rZVT+ljZXwsu4HPuejV/gIgjdoqKrnq6UAXdH1X7R6jy3Rf/7LQ==
X-Received: by 2002:a17:90b:480b:b0:279:5e3:7f6c with SMTP id kn11-20020a17090b480b00b0027905e37f6cmr3903495pjb.7.1695989522451;
        Fri, 29 Sep 2023 05:12:02 -0700 (PDT)
Received: from ?IPv6:2409:4063:6d8e:3a0d:a52b:e67f:d8b3:45d0? ([2409:4063:6d8e:3a0d:a52b:e67f:d8b3:45d0])
        by smtp.gmail.com with ESMTPSA id iq12-20020a17090afb4c00b00274262bcf8dsm1302140pjb.41.2023.09.29.05.12.00
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 05:12:02 -0700 (PDT)
Reply-To: businesssolutionsrocks23@gmail.com
From:   Ayan Seth <ayansethjk3@gmail.com>
To:     linux-block@vger.kernel.org
Subject: RE: Meeting request with
Message-ID: <6c0f8ce1-47b0-7ddf-0e95-a694d7eeaf9e@gmail.com>
Date:   Fri, 29 Sep 2023 17:41:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi ,

Circling back on my previous email if you have a requirement for Mobile 
App OR Web App Development service.

Can we schedule a quick call for Tuesday (3rd october) or Wednesday (4th 
October)?

Please suggest a suitable time based on your availability. Please share 
your contact information to connect.

Best Regards,
Ayan Seth

On Tuesday 22 August 2023 5:43 PM, Ayan Seth wrote:


Hi ,

We are a Software development company creating solutions for many 
industries across all over the world.

We follow the latest development approaches and technologies to build 
web applications that meet your requirements.

Our development teams only use modern and scalable technologies to 
deliver a mobile or web application the way you mean it.

Can we have a quick call to discuss if we can be of some assistance to 
you? Please share your phone number to reach you.

Thanks & Regards,
Ayan Seth
