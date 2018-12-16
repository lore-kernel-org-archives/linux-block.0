Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC1EC43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68963204FD
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WCQ18VkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeLPQ5P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:57:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43409 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730496AbeLPQ5P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:57:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so4974707plb.10
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 08:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uDwgMFffZKXaykj8t+6KinFZN8BlfvqAYMqUpVEPHTQ=;
        b=WCQ18VkS1txrhinqj3C7ufOmCeqMLQNyqBFNmhhkfXQZTkadSIZmkji+wei8KhDlqC
         T+KUSmZem+FtSx1ZFAsHyvjawfZF2X0Qwxer4XpCdyyO8b6VHJ3jqB+6qLb1UqX3R3xP
         GqjGbviBViCFXYFUx5Ku200dDb8EbdQmdMdS78TLiOWzfypVkRrhaGcatAEj3QAYR2we
         wsHiy/bqNSbXQcg+KSzBBZZ2dBs8ote1AmgUVGDOsPl04z51E3L0lTh4npltZpUEhzRq
         z1cm2De6nvF5IzW6YPwjjK29ViWwCTvRK98VtK2j3kHhJ0LLP/XMth7AQdodbNW1THgz
         s+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uDwgMFffZKXaykj8t+6KinFZN8BlfvqAYMqUpVEPHTQ=;
        b=EwJ+uCAPMJ9RZGJOH9HQDzjkfx4RPayXrfqimXiOTkojk1MAJxCsQId7QhawfaUS9z
         uOrp16gqpwxdR2XNegqTFmL+Xw3yRh3wz0guoMop3mGZXFSSbg5YmxUcnF6pFxA+WaQ0
         aylhP3bXd1PGp/lDUSCtIx/u/AC2WWk/+BVu6SEgDxsoMj7TZ9z73zm0Ah3Pkr6+0v8K
         8I8SEe1hHAdzZjsvbc6wpgTjtValhScozRdYQKj00jtYjSIbDrLDrKbD1Wux4umTl6i+
         5oIpuJh2zdDXQmrzF2ITAvKB86z1h5cXaeYgG+3q8rFehc3tKWwhnaFaPeY25ZfoMCaG
         H48Q==
X-Gm-Message-State: AA+aEWY3R2V9RiJTHx+gdG9t5RAMFw4M+X5Hmfh+/NrqvC8c1kewLHNN
        qf7wg677twPEeiyKQ1NAbYRN8A==
X-Google-Smtp-Source: AFSGD/Xnm+ALyj3aaGdBSZV7+j+fu8i2/UPbSrlaa3ENY+oCEcmtgduDKZEON7SCv39csVDoHSDkCw==
X-Received: by 2002:a17:902:c5:: with SMTP id a63mr10031624pla.267.1544979434691;
        Sun, 16 Dec 2018 08:57:14 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t5sm13497288pfb.60.2018.12.16.08.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 08:57:13 -0800 (PST)
Subject: Re: [PATCH 16/26] fs: add fget_many() and fput_many()
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, jmoyer@redhat.com, clm@fb.com,
        viro@zeniv.linux.org.uk
References: <20181213175645.22181-1-axboe@kernel.dk>
 <20181213175645.22181-17-axboe@kernel.dk> <20181216163736.GB13234@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <db9a00b4-93ee-31b7-dff2-9f9c4f1e278c@kernel.dk>
Date:   Sun, 16 Dec 2018 09:57:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216163736.GB13234@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/18 9:37 AM, Christoph Hellwig wrote:
> [adding Al, I think we really want him to review anything fget
>  related]
> 
> On Thu, Dec 13, 2018 at 10:56:35AM -0700, Jens Axboe wrote:
>> Some uses cases repeatedly get and put references to the same file, but
>> the only exposed interface is doing these one at the time. As each of
>> these entail an atomic inc or dec on a shared structure, that cost can
>> add up.
>>
>> Add fget_many(), which works just like fget(), except it takes an
>> argument for how many references to get on the file. Ditto fput_many(),
>> which can drop an arbitrary number of references to a file.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/file.c            | 15 ++++++++++-----
>>  fs/file_table.c      | 10 ++++++++--
>>  include/linux/file.h |  2 ++
>>  include/linux/fs.h   |  3 ++-
>>  4 files changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/file.c b/fs/file.c
>> index 7ffd6e9d103d..ad9870edfd51 100644
>> --- a/fs/file.c
>> +++ b/fs/file.c
>> @@ -676,7 +676,7 @@ void do_close_on_exec(struct files_struct *files)
>>  	spin_unlock(&files->file_lock);
>>  }
>>  
>> -static struct file *__fget(unsigned int fd, fmode_t mask)
>> +static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
>>  {
>>  	struct files_struct *files = current->files;
>>  	struct file *file;
>> @@ -691,7 +691,7 @@ static struct file *__fget(unsigned int fd, fmode_t mask)
>>  		 */
>>  		if (file->f_mode & mask)
>>  			file = NULL;
>> -		else if (!get_file_rcu(file))
>> +		else if (!get_file_rcu_many(file, refs))
>>  			goto loop;
>>  	}
>>  	rcu_read_unlock();
>> @@ -699,15 +699,20 @@ static struct file *__fget(unsigned int fd, fmode_t mask)
>>  	return file;
>>  }
>>  
>> +struct file *fget_many(unsigned int fd, unsigned int refs)
>> +{
>> +	return __fget(fd, FMODE_PATH, refs);
>> +}
>> +
>>  struct file *fget(unsigned int fd)
>>  {
>> -	return __fget(fd, FMODE_PATH);
>> +	return fget_many(fd, 1);
> 
> Can we just call __fget directly here?  That is a little easier
> to follow, and might actually generate better code if the compiler
> is inliner challenged (which they often seem to be).

Certainly, it'd be the same thing. I kind of like having it follow the
natural path to get there, unless there are strong objections to
bypassing that step.

>> +void fput(struct file *file)
>> +{
>> +	fput_many(file, 1);
>> +}
>> +
>> +
> 
> Double empty line here.

Fixed.

>> +#define get_file_rcu_many(x, cnt) atomic_long_add_unless(&(x)->f_count, (cnt), 0)
> 
> This could use a line break to be easier readable and not spill over
> 80 chars.  Otherwise this looks fine to me.

Fixed.


-- 
Jens Axboe

