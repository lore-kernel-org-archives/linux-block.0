Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADDCC282DE
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF8720880
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="k0Yr6hUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfDHQ5t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:57:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37075 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfDHQ5t (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 12:57:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so7676300ply.4
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X9DEftMRHX1cTeld1z4NOF2ma7HZecszHQHSDO73rq4=;
        b=k0Yr6hUn0V3/gqaLh4Lh2ysHPlexMzD11JWufDkgD3gyXyYZDDN+jBi26ah1cvKCYf
         oC/KzRgJze5xSApX+Lne79nSq097xi1etnkisQhGp0EMySJz/MBND62hCS2s8BI0LHij
         s5itrq18Zq6Mrtl0fCUnSonwSBshKp0i6h4AkulcSHnzbHO4cWdt3FKcxQgTdzX/qLzl
         TTX9BiWo5xjZZXfuZz728L7VOjRsnIcFLW8CgMnUmcP66wKORbuHLdzvbZFANH9HA+b2
         XFWGTlSlvullS/PIOF29r8qlNWsyZzCsM7GADWs4/SZT4RLY5gMejtYMCRuGAY6+AiJK
         Obcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X9DEftMRHX1cTeld1z4NOF2ma7HZecszHQHSDO73rq4=;
        b=pJS8pnkiW6+IEMK0w5RePHw6Vczxlni94eI+2JPEVA2ezZ0J1u8q1EPxRtTkLASVPm
         gAa7MFA4aULnJxutq6HCtJnYlaHZ49bfpSru2UyJC7HNDojm/WLxnHbcZDlC3qo0shPG
         8djs7VmrkY1dRbO7cNqLYkD6JH8UbK96J6pIjH32oUkiNnyhHDDHz7d7Rt6QHROeU3fY
         Gv+fT5KSLF3tPIo3Gd/ECqdFg0fxMLgTq//Ub5Udjk+KONVaNJRi+V3PEwlMbS0Frmdu
         Lcfgt2TqOyrkNVo1NCvrPWC9gM5RS+803Zg80nq00h3nmai6SwUAmi2P1jco2x4zutZx
         2egw==
X-Gm-Message-State: APjAAAVYaJLq2lVu1j92rinILYap/9xWiMy4uduxAIOjrjjFlxHvnlBE
        /aj+aw5oJ69pxY1Qn7hzofs8cOFMif+5+g==
X-Google-Smtp-Source: APXvYqxnUjmWt1ezECpcZEM8bz3R2frtm5orZF09mplHLe8wtYkWJoosDIE9+NQ3wjMO501P3UuZMg==
X-Received: by 2002:a17:902:7885:: with SMTP id q5mr31848557pll.12.1554742667931;
        Mon, 08 Apr 2019 09:57:47 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p189sm33040429pfg.184.2019.04.08.09.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 09:57:47 -0700 (PDT)
Subject: Re: [PATCH V2] block: fix build warning in merging bvecs
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20190402022644.7812-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3984b306-9a7c-3cf0-19df-ab7eda7ff13b@kernel.dk>
Date:   Mon, 8 Apr 2019 10:57:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402022644.7812-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/1/19 8:26 PM, Ming Lei wrote:
> Commit f6970f83ef79 ("block: don't check if adjacent bvecs in one bio can
> be mergeable") changes bvec merge by only considering two bvecs from
> different bios. However, if the former bio doesn't inlcude any io bvec,
> then the following warning may be triggered:
> 
>  warning: ‘bvec.bv_offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> In practice, it shouldn't be triggered.
> 
> Fixes it by adding check on former bio, the check shouldn't add any cost
> given 'bio->bi_iter' can be hit in cache.

Applied, thanks.

-- 
Jens Axboe

