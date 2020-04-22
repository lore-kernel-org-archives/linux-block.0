Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B3EC5518A
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 08:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F6D2071E
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 08:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgDVIUc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:20:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33985 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgDVIUb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 04:20:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id x23so923653lfq.1;
        Wed, 22 Apr 2020 01:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Uyk+uICGnp6D8nQZ0Jii8T20Qhw16Iodx99VvAMvM10=;
        b=iSbMDln03EjxzajPF5EllZvU5Zrx654EaoL2el8WPmyhU5FXGBBL5OybJnn7IkX6MX
         nqY+/bHhdn6LCfAQkWBLNOjFmrf+lpA3JI7OWuZPPF4zR/IPg5VsHayjychjIPpxX4hW
         zoT/iy7rbrFm6kx0Wnr9M4bRDdBA0X4KWt4YHQO9OaXgCxN5y7ZOLmy1edlVsWuVTGO6
         LcMbi4S0kCnsgrzoeQeCxdZfShP5C4OGbwSNMYKzXMmi0W4ue4DhSm7aSsitXJ/66aws
         UV+aRtb+iBPwUNow7wxsREKvWL0cCBra5fv/WJNSaPr8wGDMjvcpiEZwp3lFqJXIESsc
         wS6w==
X-Gm-Message-State: AGi0PuaEytgWi7w0Vl+0FIrfqgjjHxG2rEL9bAocJ2kGAeSMTZD0D9UW
        D5odVAjnRIwNrCY2Yd3GfIELFbuvQTI=
X-Google-Smtp-Source: APiQypJDtj9yig0Qaw6L+/QwF0wXE7G1FJkhC83/sOafqBSEczDe6T2JBnx0Dufn+EFolkKepxREbA==
X-Received: by 2002:ac2:4836:: with SMTP id 22mr15976628lft.52.1587543626859;
        Wed, 22 Apr 2020 01:20:26 -0700 (PDT)
Received: from [192.168.8.103] ([213.87.162.215])
        by smtp.gmail.com with ESMTPSA id w9sm779114ljj.88.2020.04.22.01.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 01:20:26 -0700 (PDT)
To:     Willy Tarreau <w@1wt.eu>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200421125722.58959-1-efremov@linux.com>
 <20200421125722.58959-4-efremov@linux.com>
 <20200422070921.GA19116@infradead.org> <20200422071756.GA16814@1wt.eu>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [PATCH 3/3] floppy: suppress UBSAN warning in setup_rw_floppy()
Message-ID: <c2cc742d-23f9-ce03-c326-7df648161427@linux.com>
Date:   Wed, 22 Apr 2020 11:20:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422071756.GA16814@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 4/22/20 10:17 AM, Willy Tarreau wrote:
> On Wed, Apr 22, 2020 at 12:09:21AM -0700, Christoph Hellwig wrote:
>> On Tue, Apr 21, 2020 at 03:57:22PM +0300, Denis Efremov wrote:
>>> UBSAN: array-index-out-of-bounds in drivers/block/floppy.c:1521:45
>>> index 16 is out of range for type 'unsigned char [16]'
>>> Call Trace:
>>> ...
>>>  setup_rw_floppy+0x5c3/0x7f0
>>>  floppy_ready+0x2be/0x13b0
>>>  process_one_work+0x2c1/0x5d0
>>>  worker_thread+0x56/0x5e0
>>>  kthread+0x122/0x170
>>>  ret_from_fork+0x35/0x40
>>>
>>> >From include/uapi/linux/fd.h:
>>> struct floppy_raw_cmd {
>>> 	...
>>> 	unsigned char cmd_count;
>>> 	unsigned char cmd[16];
>>> 	unsigned char reply_count;
>>> 	unsigned char reply[16];
>>> 	...
>>> }
>>>
>>> This out-of-bounds access is intentional. The command in struct
>>> floppy_raw_cmd may take up the space initially intended for the reply
>>> and the reply count. It is needed for long 82078 commands such as
>>> RESTORE, which takes 17 command bytes. Initial cmd size is not enough
>>> and since struct setup_rw_floppy is a part of uapi we check that
>>> cmd_count is in [0:16+1+16] in raw_cmd_copyin().
>>>
>>> The patch replaces array subscript with pointer arithetic to suppress
>>> UBSAN warning.
>>
> 
> But isn't it a problem if struct floppy_raw_cmd is exposed to uapi ?
> That said I remember a discussion with Linus who said that most if not
> all of the floppy parts leaking to uapi were more of a side effect of
> the include files reordering than a deliberate decision to expose it.
> So maybe that could remain the best solution indeed.

struct floppy_raw_cmd is input/output structure for FDRAWCMD ioctl.

> 
> I must say I don't feel very comfortable either with replacing p[i]
> with *(p+i) given that they are all supposed to be interchangeable and
> equivalent (as well as i[p] as strange as it can look). So we're not
> really protected against a later mechanical change or cleanup that
> reintroduces it :-/

>> Urghh.  I think the better way would be to use a union that creates
>> a larger cmd field, or something like:
>>
>> struct floppy_raw_cmd {
>> 	...
>> 	u8 buf[34];
>>
>> #define BUF_CMD_COUNT	0
>> #define BUF_CMD		1
>> #define BUF_REPLY_COUNT	17
>> #define BUF_REPLY	18
>>
>> and use addressing based on that.


What do you think about changing it this way?

struct floppy_raw_cmd {
 
        unsigned char rate;
 
-#define FD_RAW_CMD_SIZE 16
+#define FD_RAW_CMD_SIZE 33
 #define FD_RAW_REPLY_SIZE 16
 
        unsigned char cmd_count;
-       unsigned char cmd[FD_RAW_CMD_SIZE];
-       unsigned char reply_count;
-       unsigned char reply[FD_RAW_REPLY_SIZE];
+       union {
+               struct {
+                       unsigned char reserved[16];
+                       unsigned char reply_count;
+                       unsigned char reply[FD_RAW_REPLY_SIZE];
+               };
+               unsigned char cmd[FD_RAW_CMD_SIZE];
+       };
        int track;

Denis
