Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B43C2BA17
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 15:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C55248AB
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 15:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fSwjA78f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgDFPch (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:32:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37956 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbgDFPcg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Apr 2020 11:32:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id c21so7682945pfo.5
        for <linux-block@vger.kernel.org>; Mon, 06 Apr 2020 08:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7VmKlpRwdchNnRw95jny/lwjYGByipa2aNaHLJyO/h8=;
        b=fSwjA78fiVaYhEdu9cm73uYz/GAccmeCiK1ZZF4g8pB784H2TQnUZMAM8MtjfAJMyO
         d9nJwtpKzHyK/XvD/i+d7ASW3J9bb4c7iQX9qg/LLhrQETL/w11itQZOIeszuwZg5Jjo
         RJBvnVHRsjFxp7Z/Ert7W22fPXChXSFDFF6hZlbXucc0hlr1ICiSYYdgdhzsco7b8pG+
         Awuzv4X/uWaOAWweNwJbEay4bCblOlH2L3I5sUGoYCUZGTY52UF03KCPX4ZoJPHLHZqn
         vSNV4ygEdkOYPQj6l36AWDRCY1kFnk/Xug2noBWkjc/uqNtPB2QnFnegINZXsUjA6CpE
         Gwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7VmKlpRwdchNnRw95jny/lwjYGByipa2aNaHLJyO/h8=;
        b=Q0rUOiogRAjSIB78vZ10sYh96NYL1adlzN9egTV5VdxF7thuctWLlev4oboAsMMvuX
         0sLFr1OlPUYFy0grOY8l7m4rpzpWxiCWiFLTk2zVlbK5PR6c307yicIFJq6IlKk04X0x
         hi2SYM04IEdJ9sfRrJtRf6yNNcuaoksLwWvyZiXlsyin2Mk95X/BVVyOOCtzWrQy4/UK
         5Duxl2wpfbETbh6ezBhODa9PmcDAHo6J0trjSw7YgnXW/rdF3VTJ27r6Oem4tYtJEBze
         jC0AI5Zvc1gxJngfjBOKh2tKc5dFF+s8ORSAsOojIF2kgw9sELo/F8bBZVPsXKcZkNE7
         15wA==
X-Gm-Message-State: AGi0PublUTs0r9zybVKR8WQqUdVS6kyluOKiGb12t23ZBw73oCgaIDZ/
        1sYO39J6jvhyV/yGn5FAVPzxM15n+J61+Q==
X-Google-Smtp-Source: APiQypJ8XlUqjCjeOBH/m7/pYNHylMk/OkqjgnSy2HPHGdoWE0S3xKIKTwqJVb4auTupdnpPuda+rA==
X-Received: by 2002:aa7:99c8:: with SMTP id v8mr23502pfi.151.1586187154140;
        Mon, 06 Apr 2020 08:32:34 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:b100:a89e:176d:c04d? ([2605:e000:100e:8c61:b100:a89e:176d:c04d])
        by smtp.gmail.com with ESMTPSA id v42sm11233988pgn.6.2020.04.06.08.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 08:32:33 -0700 (PDT)
Subject: Re: [PATCH 1/1] s390: Cleanup removed IOSCHED_DEADLINE
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200406074118.86849-1-sth@linux.ibm.com>
 <20200406074118.86849-2-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0efad2a5-90f5-8ccf-169e-9715a64a4bb0@kernel.dk>
Date:   Mon, 6 Apr 2020 08:32:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200406074118.86849-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/20 1:41 AM, Stefan Haberland wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> CONFIG_IOSCHED_DEADLINE is gone since commit f382fb0bcef4 ("block:
> remove legacy IO schedulers").

Isn't this a leftover thing from when dasd selected deadline
internally? I don't think we need this anymore, just kill the
select completely.

-- 
Jens Axboe

