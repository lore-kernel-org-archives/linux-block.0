Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F321DC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2CB208E7
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GI+nfCuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2CB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbeLFRsc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:48:32 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42603 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFRsc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 12:48:32 -0500
Received: by mail-io1-f66.google.com with SMTP id x6so1033696ioa.9
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d8mJ/1oPMGXWH3lpm0E1TL2ibkbj3RWt/CxYc8WkoDM=;
        b=GI+nfCuyrNQ+nkciSvOblJARjwyF3UxVJClSo75hB/7x0iIOb0B8JoasPpMmJ4pKMw
         fZKJzxfSwnGkP8lrSLbEUDkos9ajGfn/Eo1sYPc1Ei60geQ7h7n/NJLHU62EOLx48ZCB
         JS6oVTwqrUPMxgZILg2T0OpjLa9hZlpOge1aaQr98GmdkJZ28JFHQ+KgA1uFRnrEAtvb
         cIG82qLu/+6tI4iDMADCMnMCRFS3tbNO9MSueLEAKjv3Lw5LzYeV6X8ylzI544gy7vJr
         FmRxIaiXl5vWw653bjYbXcUEPozAWMzapFPaXh+T0ecOU3w9MkkkPG4lOdy8uozOSJB7
         WLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d8mJ/1oPMGXWH3lpm0E1TL2ibkbj3RWt/CxYc8WkoDM=;
        b=qM+G4m4HcDTzjjbAi7ihUsZ3uUTn8TtCOd9S8YFgU43QhfTZSDfVFCanR/cR/mmtUt
         Hcm+l0FYAV7b4XGWDbCJ7xYCYTa8ogeBOof3VXSIqOOXH+BNF9/nTTmGv4cYhTW1yKSu
         GZdsbETkz5fq+fO1b+Hoa0XuYAzE1vzBJ3gcF5aa9i7qt6ievmEi0ePhsQGiK52G7tzd
         +5gvdAivkNa909QeycdW3teA2OoRJhS2dacXRgREZaXVsdtPW8OMK5XbFKDDDqmHd/UZ
         hFZeOS/S/Jjyy/USu1LGDM7hEx9oc2hKgoxcDCHkG5RZOHmBaGWLJ4QL/gYJcXFJai8o
         2CQA==
X-Gm-Message-State: AA+aEWZPVP0SmIzjKU3hGN2fgA41Rvuhl8HDD4Zq3aCHcnECy6UpKyrQ
        eI/7hpMcAivZzhaFwRb8SARIKA==
X-Google-Smtp-Source: AFSGD/W5ltdpfN0EfUvcSsqw3bW1oFf0+NS7fylXu/TLm+F/i6LMs7tmIABOx4CjxWAGdQJNUI1ITg==
X-Received: by 2002:a6b:2a05:: with SMTP id q5mr25808143ioq.188.1544118510502;
        Thu, 06 Dec 2018 09:48:30 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l11sm431322iob.24.2018.12.06.09.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:48:29 -0800 (PST)
Subject: Re: for-next branch and blktests/srp
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <1544114872.185366.250.camel@acm.org>
 <41bbac1e-7461-4378-a18d-531b625d6784@kernel.dk>
 <1544116771.185366.261.camel@acm.org>
 <707b709c-547f-b330-bd37-29b8fc427827@kernel.dk>
Message-ID: <a73ef579-e4e8-f245-b203-1b52eb41af78@kernel.dk>
Date:   Thu, 6 Dec 2018 10:48:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <707b709c-547f-b330-bd37-29b8fc427827@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 10:28 AM, Jens Axboe wrote:
> On 12/6/18 10:19 AM, Bart Van Assche wrote:
>> On Thu, 2018-12-06 at 10:00 -0700, Jens Axboe wrote:
>>> On 12/6/18 9:47 AM, Bart Van Assche wrote:
>>>> If I merge Jens' for-next branch with Linus' master branch, boot the
>>>> resulting kernel in a VM and run blktests/tests/srp/002 then that test
>>>> never finishes. The same test passes against Linus' master branch. I
>>>> think this is a regression. The following appears in the system log if
>>>> I run that test:
>>>
>>> You are running that test on a dm device? Can you shed some light on
>>> how that dm device is setup?
>>
>> Hi Jens,
>>
>> The dm device referred to in my e-mail is a dm-mpath device created by test
>> srp/002. All parameters of that device are under control of that test script.
>> From the srp/002 test script:
>>
>> DESCRIPTION="File I/O on top of multipath concurrently with logout and login (mq)"
>>
>> From srp/multipath.conf:
>>
>> defaults {
>> 	find_multipaths		no
>> 	user_friendly_names	yes
>> 	queue_without_daemon	no
>> }
>>
>> devices {
>> 	device {
>> 		vendor		"LIO-ORG|SCST_BIO|FUSIONIO"
>> 		product		".*"
>> 		features	"1 queue_if_no_path"
>> 		path_checker	tur
>> 	}
>> }
> 
> 5 kernel compiles later, and I think I'm almost ready to run it...

axboe@dell:/home/axboe/git/blktests $ sudo ./check srp/002
srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
    runtime  33.689s  ...  32.212s
    --- tests/srp/002.out	2018-11-09 08:42:22.842029804 -0700
    +++ /home/axboe/git/blktests/results/nodev/srp/002.out.bad	2018-12-06 10:45:35.995183521 -0700
    @@ -1,2 +1 @@
     Configured SRP target driver
    -Passed

It runs for about 32-33s every time and then I get this. The fio output shows this:

data-integrity-test-mq: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
...
fio-3.12-27-g68af
Starting 16 threads
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
data-integrity-test-mq: Laying out IO file (1 file / 1MiB)
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.14.0: Input/output error: read offset=724992, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.5.0: Input/output error: read offset=983040, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.7.0: Input/output error: write offset=700416, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.8.0: Input/output error: write offset=237568, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.9.0: Input/output error: write offset=1277952, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.9.0: Input/output error: write offset=970752, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.9.0: Input/output error: write offset=974848, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.9.0: Input/output error: write offset=978944, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.9.0: Input/output error: write offset=983040, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.15.0: Input/output error: write offset=172032, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.13.0: Input/output error: write offset=237568, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.3.0: Input/output error: write offset=294912, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.11.0: Input/output error: write offset=1245184, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.12.0: Input/output error: write offset=884736, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=389120, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=393216, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=397312, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=364544, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=368640, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=663552, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.1.0: Input/output error: write offset=1126400, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=102400, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=778240, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.6.0: Input/output error: write offset=221184, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.10.0: Input/output error: write offset=696320, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=286720, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=290816, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=647168, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.6.0: Input/output error: write offset=61440, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.0.0: Input/output error: write offset=73728, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=303104, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=311296, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.6.0: Input/output error: write offset=245760, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=65536, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=57344, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.6.0: Input/output error: write offset=290816, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=618496, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=503808, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.6.0: Input/output error: write offset=339968, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=905216, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=675840, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.6.0: Input/output error: write offset=311296, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=253952, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=937984, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.6.0: Input/output error: write offset=425984, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=114688, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=258048, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.6.0: Input/output error: write offset=507904, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.4.0: Input/output error: write offset=212992, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=262144, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.6.0: Input/output error: write offset=524288, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=266240, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.6.0: Input/output error: write offset=552960, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=270336, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.6.0: Input/output error: write offset=557056, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=245760, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.6.0: Input/output error: write offset=638976, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=249856, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1249280, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1003520, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1007616, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1150976, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=806912, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1011712, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=540672, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=544768, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=507904, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=811008, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=892928, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=585728, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1040384, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=831488, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=737280, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=638976, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1142784, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=335872, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1146880, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1085440, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1138688, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=217088, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=237568, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=241664, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1220608, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=999424, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=860160, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=864256, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=827392, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=598016, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1024000, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=663552, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=675840, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=688128, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=692224, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1064960, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=704512, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=716800, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=741376, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=778240, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=929792, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=933888, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1159168, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=303104, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1163264, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=393216, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=397312, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=1228800, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=659456, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=950272, buflen=4096
fio: io_u error on file /home/axboe/git/blktests/results/tmpdir.srp.002.7WR/mnt0/data-integrity-test-mq.2.0: Input/output error: write offset=110592, buflen=4096
fio: pid=7922, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7923, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7931, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7932, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7934, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7925, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7926, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7930, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7935, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7929, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7924, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7921, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7928, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7920, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7933, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error
fio: pid=7927, err=5/file:io_u.c:1789, func=io_u error, error=Input/output error

data-integrity-test-mq: (groupid=0, jobs=16): err= 5 (file:io_u.c:1789, func=io_u error, error=Input/output error): pid=7920: Thu Dec  6 10:45:47 2018
  read: IOPS=12.2k, BW=47.5MiB/s (49.8MB/s)(369MiB/7769msec)
  write: IOPS=12.2k, BW=47.1MiB/s (49.4MB/s)(378MiB/8024msec); 0 zone resets
   bw (  KiB/s): min=48208, max=112000, per=100.00%, avg=85859.56, stdev=1118.52, samples=144
   iops        : min=12050, max=28000, avg=21464.33, stdev=279.65, samples=144
  cpu          : usr=2.78%, sys=2.21%, ctx=93124, majf=0, minf=132
  IO depths    : 1=0.3%, 2=0.6%, 4=1.3%, 8=2.6%, 16=5.2%, 32=10.3%, >=64=79.7%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.6%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.4%, >=64=0.0%
     issued rwts: total=94632,97502,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=47.5MiB/s (49.8MB/s), 47.5MiB/s-47.5MiB/s (49.8MB/s-49.8MB/s), io=369MiB (387MB), run=7769-7769msec
  WRITE: bw=47.1MiB/s (49.4MB/s), 47.1MiB/s-47.1MiB/s (49.4MB/s-49.4MB/s), io=378MiB (396MB), run=8024-8024msec

Disk stats (read/write):
    dm-2: ios=85051/90524, merge=9581/9463, ticks=2200798/5420861, in_queue=7709829, util=97.61%, aggrios=82306/87731, aggrmerge=0/0, aggrticks=107774/142105, aggrin_queue=264726, aggrutil=98.23%
  sdh: ios=82306/87731, merge=0/0, ticks=107774/142105, in_queue=264726, util=98.23%

which would result in a non-zero exit, which should be expected for this
test?

-- 
Jens Axboe

