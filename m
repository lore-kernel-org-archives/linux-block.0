Return-Path: <SRS0=A/1A=5J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98B2C10DCE
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 02:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9817420409
	for <linux-block@archiver.kernel.org>; Tue, 24 Mar 2020 02:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCXC6f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 22:58:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39208 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgCXC6f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 22:58:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id b22so8280719pgb.6
        for <linux-block@vger.kernel.org>; Mon, 23 Mar 2020 19:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nxwzl9MHgIC6UOLgR0Pg7DWA2Unu46j+8VMZfyHDZkM=;
        b=E6XEoU7x+cf3z24xmbxNjEmUXc/JZZSU5PXFe2OafpLTQ7TEDb9yw1hdCN1ilUJSML
         nZp1ovfdBkE+WkFR2OcPL1dR0IIREc0BMCVCUxsVA5XBh8Tx9daHkiQyib+cHczJ8IMH
         d1XDzrck7TQTBgw8h2xtZzGJy5ouP+ymQPyowcjXJnAtIigGJ22Y7mxya9zbUliwB779
         dHIhcycRS2RHa+7wImxbFJUmjvdtPqubyiHV1DhKB9D9BRVoAdUap9LAtBUB+Po/QPDI
         A+99URalv1k3lLXJA1YC8YfbWZq1PJXnLb+fLNPyqt49dKAcYQCPRf3AnrKNLJeqQhju
         8+Xw==
X-Gm-Message-State: ANhLgQ0J8cdabuCJUDSLm37xl5nKFEYnnAr5M40ijZmDp0ZZV1Qctlgp
        sfeTmW9YMZj6NoTZDMVmg4k=
X-Google-Smtp-Source: ADFU+vu7LJadFt07m8iAhORS0ANVxjqp3tW1RMT00yL/4J1sLVXwwKC22GEE7ZrxilqOHYov3IMJiQ==
X-Received: by 2002:aa7:81d6:: with SMTP id c22mr27091305pfn.147.1585018714265;
        Mon, 23 Mar 2020 19:58:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:39fc:1d7f:ee6a:174f? ([2601:647:4000:d7:39fc:1d7f:ee6a:174f])
        by smtp.gmail.com with ESMTPSA id 26sm14559098pfp.130.2020.03.23.19.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 19:58:33 -0700 (PDT)
Subject: Re: [PATCH blktests v3 3/4] Introduce the function
 _configure_null_blk()
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20200320222413.24386-1-bvanassche@acm.org>
 <20200320222413.24386-4-bvanassche@acm.org>
 <20200323111950.6xsolscppgtzwp7o@beryllium.lan>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <70949ba3-cf38-8cc0-f2a1-5e2b1fec70ba@acm.org>
Date:   Mon, 23 Mar 2020 19:58:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323111950.6xsolscppgtzwp7o@beryllium.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-03-23 04:19, Daniel Wagner wrote:
> On Fri, Mar 20, 2020 at 03:24:12PM -0700, Bart Van Assche wrote:
>> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
>> index a56e7a8269db..7e610a0ccbbb 100644
>> --- a/common/multipath-over-rdma
>> +++ b/common/multipath-over-rdma
>> @@ -620,18 +620,11 @@ run_fio() {
>>  configure_null_blk() {
>>  	local i
>>  
>> -	(
>> -		cd /sys/kernel/config/nullb || return $?
>> -		for i in nullb0 nullb1; do (
>> -			{ mkdir -p $i &&
>> -				  cd $i &&
>> -				  echo 0 > completion_nsec &&
>> -				  echo 512 > blocksize &&
>> -				  echo $((ramdisk_size>>20)) > size &&
>> -				  echo 1 > memory_backed &&
>> -				  echo 1 > power; } || exit $?
>> -		) done
>> -	)
>> +	for i in nullb0 nullb1; do
>> +		_configure_null_blk nullb$i completion_nsec=0 blocksize=512 \
> 
> I think this should be:
> 
> 		_configure_null_blk $i completion_nsec=0 blocksize=512 \

Good catch, will fix.

Thanks,

Bart.
