Return-Path: <SRS0=xgQW=U4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAC0C4321A
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF502075B
	for <linux-block@archiver.kernel.org>; Sat, 29 Jun 2019 16:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Xf/owdAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfF2Q0z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jun 2019 12:26:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32902 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfF2Q0z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 12:26:55 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so19259371iop.0
        for <linux-block@vger.kernel.org>; Sat, 29 Jun 2019 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G4jzVLONMzA8LW+cz32727nywRT+O/K9mkpd2LMUTPo=;
        b=Xf/owdAundwCMeibMCAixAOmLvLrzLUlMemlcf+2ni29EvOJIIssxdSE7aBhHnwnQJ
         JQGeWHaeMB+KC0p3WFTZ5Eq6NummvATg9V/AvGWTDBlXtKP7iciCOt5QqYyAX2DBSams
         fEjizaGD1KtppcisjfhvlcIi/MZvZs3F5v8cliaShqJeK3mbuPnUqV9TjH9rRTHVYkf3
         Fh4w9BU9hZxsnkLEW0gltClsnYIjQQ52YHmRYI+tWU+tobCoZLW2OI6uLwDg/ZUCEHLj
         Gqqbif+WYhlEDSn/VrfsiR5YM5/ydFfoyt3f2DwTe3grZ9CSII8E4b7mUBjWF77jV5q3
         pHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G4jzVLONMzA8LW+cz32727nywRT+O/K9mkpd2LMUTPo=;
        b=uJRDeH+riumIi/nGi9GSr+46XEMhGVdhBNtlzWYgTFlQ6KYPF5YJAZA9VIKmGnyevY
         Sa2vZjyg1rmfsbLa1m2oUOsSV8f3mc+qEvCFWSx0/1kXVzdvAFG5aLg/v+kiC2u8mjC7
         oGMuK+0o4x9y3z3ugL4YAx9z0k7no0FSuL0w12sUUsaKbFnkT367T6RPFjZtkbCby+Yo
         hCGEX+FnXLilofqQLMPGaM1+xjqaIdopKDPhcNlKiw4j4daIblcJqYbRM5dlvJrmeuIt
         HQmZlnIbJsJ0PY54kUmmdZmqXdgw9q05wimxnQulweq+30mcEnuCWUUl0iEB60MDMWL7
         Bwrg==
X-Gm-Message-State: APjAAAWW+puJ9VvcKxbAjdSTJeFA0SY9OAsaO9KsVRfgrwjp57n+nAhN
        3yhYmR0QPLQzRB9tfjujgy9YbXb+dw18Gw==
X-Google-Smtp-Source: APXvYqycNxLHpepCdAZDZVT6ow79EJPxyGAuh2RMGCeaTido8PFJL0d1hgbj5OP9G9nT13hAtLzTHw==
X-Received: by 2002:a02:c50a:: with SMTP id s10mr18670838jam.106.1561825614402;
        Sat, 29 Jun 2019 09:26:54 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d7sm4316198iob.67.2019.06.29.09.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 09:26:53 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
To:     Scott Bauer <sbauer@plzdonthack.me>
Cc:     jonathan.derrick@intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zub@linux.fjfi.cvut.cz" <zub@linux.fjfi.cvut.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jonas.rabenstein@studium.uni-erlangen.de" 
        <jonas.rabenstein@studium.uni-erlangen.de>
References: <1558471606-25139-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <7ee5d705c12d770bf7566bce7d664bf733b25206.camel@intel.com>
 <20190629161947.GA20127@hacktheplanet>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3074ee1-0506-511d-c29c-44effb4eda97@kernel.dk>
Date:   Sat, 29 Jun 2019 10:26:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190629161947.GA20127@hacktheplanet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/19 10:19 AM, Scott Bauer wrote:
> 
> Hey Jens,
> 
> Can you please stage these for 5.3 aswell?

Yes, looks fine to me. But it conflicts with the psid revert in terms
of ioctl numbering. You fine with me renumbering IOC_OPAL_MBR_DONE to:

#define IOC_OPAL_MBR_DONE           _IOW('p', 233, struct opal_mbr_done)

-- 
Jens Axboe

