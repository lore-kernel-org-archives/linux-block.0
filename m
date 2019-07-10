Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E5C74A36
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8A920651
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nL2ApRDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfGJUFl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:05:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42888 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfGJUFl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 16:05:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so1747124plb.9
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+J7k3U3x+MRZN/LFpUbnrqKvYz2U9hb1CG3aK8Zr/vU=;
        b=nL2ApRDlvcyc3VPFaDFLDpiqo+pa+wS/CfQsGXcOuXn8lFEq2JU3crYTE/gV79AwKV
         0f0v5IyP37gPqgruN7bofyMpjD5SGWEZuBJXSu+qj1Er2VGNTpNzbMWuXZN0nxKzfFwK
         /6RdBo5xBkPyPgCRnO8R96jBAgsoX1t8WXgoIC7Wf+1q6wKJwgBtdoU8o4yvlwCSwMS+
         2hcV1Ku1T4mTsz13i9xqiUz8pF1/e6dggnd2dsgVi2M6TwezrkxnZILY7A/tSZ4SnP0s
         ZGxLovZ+nGowDHKOmEhOURWKyBk2sUtk7b6HWr8NxuEumKpEBW4QWRulOGn5NzpF8v7E
         GNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+J7k3U3x+MRZN/LFpUbnrqKvYz2U9hb1CG3aK8Zr/vU=;
        b=QtGwcwhQ27aIJ8FqVXSGew/TirQ4c8bxLZ20XLY+RL2zmHAQhZhNfs1EX3rTysmusR
         JVtp1mfpRH75g5Km2XvHHpwHwy3B2VhZ9QjcqB8XWSzZLCHql6wE7K2/P3+MvXiB57UX
         OhDIuJnQaP6QatsievNTlPL0+lFOyGz7V+2djU+TCY2IDUz4u59BzjbcFmS14BHbZX97
         CAZNmMUoG9mPSKmEtOYMS5slPEoVbpOZtwslgng3gP5oPuxmdeX7hsbiVWW2XbxsPT74
         5AwSBnjwrzvjnSBkmrM8NZARG53qAeDMl6Pliu4lUhu2PSkmI8/j2YT8kIo3Zx9SgFTX
         t18g==
X-Gm-Message-State: APjAAAXlNSqX6MtrmVeVMVLnvHeKEafyg8B0v+er/ehKqUKH6wOs7fYb
        v7oidbWYpluCSSlwst1Z4f6JtXdeHP1xsg==
X-Google-Smtp-Source: APXvYqy6uFfDzkCbnpA9m/e7EdK5E0Wat02PTWj7Iv4RY8L39izJcg18JeOc6V7oCeyb8g2OvklnuA==
X-Received: by 2002:a17:902:26c:: with SMTP id 99mr11027plc.215.1562789140023;
        Wed, 10 Jul 2019 13:05:40 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id s66sm3500274pgs.39.2019.07.10.13.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:05:39 -0700 (PDT)
Subject: Re: [PATCH V3] block: Disable write plugging for zoned block devices
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20190710161831.25250-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c9b5b4cd-68d5-7c29-8f76-ad5b04007594@kernel.dk>
Date:   Wed, 10 Jul 2019 14:05:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710161831.25250-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks fine to me now, but doesn't apply cleanly to master/for-linus.

-- 
Jens Axboe

