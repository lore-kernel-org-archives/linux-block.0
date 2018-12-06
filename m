Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCE0C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CB820850
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d5LuC8iw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CB820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLFR2k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:28:40 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40901 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFR2j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 12:28:39 -0500
Received: by mail-io1-f65.google.com with SMTP id n9so993851ioh.7
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 09:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vqKNznAxdoeeafFQxAyVVoVzahDs65uDk6c2I7U1Tw4=;
        b=d5LuC8iwqWx0aLHpHXRzaCLCDL7f5Upfmgo9iELTdba8qly3j06s5dhciWNrJyt5iJ
         pAYF5pNDiIZ1v1p+a13WiwaXsYwnDpgydHW6uiT+9/Wlmrpbxfmx7Q+EALOLXfeYrW9f
         XAAHhz5aSYmIeHgrk1cTIEye6VuehnPNJTqEvhtCgPZjlTQyGff0tg/uSoUXk9GxkXVZ
         t4k2a8muZrTqQakW3I2kUGZmop72/FJoN22Q1ySJXThYdx1is61jJStj2+Bi3IBgmSs2
         GBTyOv1eDWPu/txoAUwFYThYlgdkvdkCScTPwCWz0dFG1WBabRBQLtwILROTBJUf+3Dl
         u5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vqKNznAxdoeeafFQxAyVVoVzahDs65uDk6c2I7U1Tw4=;
        b=XBySrRCcfx/2WxGioctn9/SgUqKD3jjwjnMuAQVIrYMXr598+QPLMo7OzB2v5ojz4I
         Y//5ZlPocqO/DxWFGOueD6lfVVPOIAnSrl6A/iHQPu17sEC+Bq3VTbbyActobPfLCE5N
         oJGui4F5rxmXwWrql5HJYN+E8LB8aXh5K69qFV1b6B2CzOWwQbqccv2Y91AvS1LWKOkE
         gJGtOP1nPIdeQP6PgCNlWYC1wuxD7MUs/5rllTWkbfQ50XxIR9RprjiS/gukp3R1WG2i
         XxC5f75hV8AAyHrtH8BbzNWb/snphRTMcEUVfH5tpVX0f9KspOd46hTHM6bxXWtNZD+d
         VUKw==
X-Gm-Message-State: AA+aEWbVyn+oC2RLGqMGtzSNw7gGlgiJe2xyQJEVDenNBjHJaRn0JjR0
        bGv6qjEjT4YX4dEyUyYT0iOHBQ==
X-Google-Smtp-Source: AFSGD/UpNLNngPoZxr7YEMkZJr0eiU5IBk4pDNKKKgbP4coZdR4o2WlMDqKQRQiX9dtq2b9GoGAihw==
X-Received: by 2002:a6b:8f91:: with SMTP id r139mr24655973iod.128.1544117318620;
        Thu, 06 Dec 2018 09:28:38 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e1sm301964iom.80.2018.12.06.09.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:28:37 -0800 (PST)
Subject: Re: for-next branch and blktests/srp
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <1544114872.185366.250.camel@acm.org>
 <41bbac1e-7461-4378-a18d-531b625d6784@kernel.dk>
 <1544116771.185366.261.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <707b709c-547f-b330-bd37-29b8fc427827@kernel.dk>
Date:   Thu, 6 Dec 2018 10:28:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544116771.185366.261.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 10:19 AM, Bart Van Assche wrote:
> On Thu, 2018-12-06 at 10:00 -0700, Jens Axboe wrote:
>> On 12/6/18 9:47 AM, Bart Van Assche wrote:
>>> If I merge Jens' for-next branch with Linus' master branch, boot the
>>> resulting kernel in a VM and run blktests/tests/srp/002 then that test
>>> never finishes. The same test passes against Linus' master branch. I
>>> think this is a regression. The following appears in the system log if
>>> I run that test:
>>
>> You are running that test on a dm device? Can you shed some light on
>> how that dm device is setup?
> 
> Hi Jens,
> 
> The dm device referred to in my e-mail is a dm-mpath device created by test
> srp/002. All parameters of that device are under control of that test script.
> From the srp/002 test script:
> 
> DESCRIPTION="File I/O on top of multipath concurrently with logout and login (mq)"
> 
> From srp/multipath.conf:
> 
> defaults {
> 	find_multipaths		no
> 	user_friendly_names	yes
> 	queue_without_daemon	no
> }
> 
> devices {
> 	device {
> 		vendor		"LIO-ORG|SCST_BIO|FUSIONIO"
> 		product		".*"
> 		features	"1 queue_if_no_path"
> 		path_checker	tur
> 	}
> }

5 kernel compiles later, and I think I'm almost ready to run it...

-- 
Jens Axboe

