Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CC7C74A5B
	for <linux-block@archiver.kernel.org>; Sat, 18 Mar 2023 12:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCRM7p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Mar 2023 08:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCRM7o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2023 08:59:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542E42799A
        for <linux-block@vger.kernel.org>; Sat, 18 Mar 2023 05:59:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id y2so7912933pjg.3
        for <linux-block@vger.kernel.org>; Sat, 18 Mar 2023 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679144383; x=1681736383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlZmOu+sjHL/CV/K7dUbiGgGhDL3HAaREA1KSNN1AwY=;
        b=zvIAh3VrBiXd+Shrazz1S9zrsVgWOS7psoF0q+xdiMdgP8YGEfvJeVz6lTZRN9Vf7I
         aLH5pnHPd/1wxFsSJNZAOMOP4zIyTyIo9yBBI0eJnVoZNZOaTvHLmteutd+6k/vPR0W9
         iALLkU4z3xI2i4tYEx2CyTUUh3Bb7q9W6ACiCfPdUkyAVpmeujWdfmxYytWQ2qX7U0Pp
         wz6uCzCKS7lZF2ZJcZ3lfygdNiySF8dyPugaVa5pTjB2972rcsENqdrx+G2BpJPNuwoA
         z166V6quJrPC9Cjz5IU7dhHzYznr5xmSIRjyZ3mVncq8DefJ3Ezxabvkk+/E0LYlKzeS
         4KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679144383; x=1681736383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlZmOu+sjHL/CV/K7dUbiGgGhDL3HAaREA1KSNN1AwY=;
        b=R87mjLBrICt064FgDIiosgF5vcsNLESYVj4SSz2wKcfDgHzKM69dw2n5ix+k0rQ7HE
         VKxydfiUQmpvswlUwKW62hLHH0xbPgI7RsXdeArqzO8+Goki3yFnUHow5FaciWNT9u3s
         ctYZY4KiDYm3JMhKYN8ozc2YpXO7w7k5HDh7dtiXYFDGCQh3G1n1g8eEj/JmvE6XRKmJ
         9vIyHRWTuDpVCX3Cj7mqFPogI75vAffvYl6c5Gds4S9odEyqxSUNIjXuH58CUdaiKYbD
         bPR6XUB7x/6Acak2JiVNbaudLl6PP8TU+y2v/C9F1gBv95LGbLP1T+noOXs3ckpSaPW9
         PMew==
X-Gm-Message-State: AO0yUKVhgj6SqUKj0lXQHqm1IOMvneTbbN+KsiDLT0Zbg7utdGqGaFEt
        bc/hOnjvTLrmTovD6sbTvl4byRJ+Ez1iK9Qtehe3ow==
X-Google-Smtp-Source: AK7set/qZExrRovDTNTYN4qtWMidb33/2LHqtMFp8nN2FshJP8hnX+eAuBpbiUld7kDP1RqJTDwv2A==
X-Received: by 2002:a17:90a:4ca4:b0:23d:1bef:8594 with SMTP id k33-20020a17090a4ca400b0023d1bef8594mr9218282pjh.1.1679144382620;
        Sat, 18 Mar 2023 05:59:42 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902760900b001a1a8e98e93sm2961579pll.287.2023.03.18.05.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 05:59:42 -0700 (PDT)
Message-ID: <3971d43f-601f-635f-5a30-df7e647f6659@kernel.dk>
Date:   Sat, 18 Mar 2023 06:59:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3 00/16] io_uring/ublk: add IORING_OP_FUSED_CMD
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20230314125727.1731233-1-ming.lei@redhat.com>
 <ZBQhSzIhvZL+83nM@ovpn-8-18.pek2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZBQhSzIhvZL+83nM@ovpn-8-18.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/17/23 2:14?AM, Ming Lei wrote:
> On Tue, Mar 14, 2023 at 08:57:11PM +0800, Ming Lei wrote:
>> Hello,
>>
>> Add IORING_OP_FUSED_CMD, it is one special URING_CMD, which has to
>> be SQE128. The 1st SQE(master) is one 64byte URING_CMD, and the 2nd
>> 64byte SQE(slave) is another normal 64byte OP. For any OP which needs
>> to support slave OP, io_issue_defs[op].fused_slave needs to be set as 1,
>> and its ->issue() can retrieve/import buffer from master request's
>> fused_cmd_kbuf. The slave OP is actually submitted from kernel, part of
>> this idea is from Xiaoguang's ublk ebpf patchset, but this patchset
>> submits slave OP just like normal OP issued from userspace, that said,
>> SQE order is kept, and batching handling is done too.
>>
>> Please see detailed design in commit log of the 2th patch, and one big
>> point is how to handle buffer ownership.
>>
>> With this way, it is easy to support zero copy for ublk/fuse device.
>>
>> Basically userspace can specify any sub-buffer of the ublk block request
>> buffer from the fused command just by setting 'offset/len'
>> in the slave SQE for running slave OP. This way is flexible to implement
>> io mapping: mirror, stripped, ...
>>
>> The 3th & 4th patches enable fused slave support for the following OPs:
>>
>> 	OP_READ/OP_WRITE
>> 	OP_SEND/OP_RECV/OP_SEND_ZC
>>
>> The other ublk patches cleans ublk driver and implement fused command
>> for supporting zero copy.
>>
>> Follows userspace code:
>>
>> https://github.com/ming1/ubdsrv/tree/fused-cmd-zc-v2
>>
>> All three(loop, nbd and qcow2) ublk targets have supported zero copy by passing:
>>
>> 	ublk add -t [loop|nbd|qcow2] -z .... 
>>
>> Basic fs mount/kernel building and builtin test are done, and also not
>> observe regression on xfstest test over ublk-loop with zero copy.
>>
>> Also add liburing test case for covering fused command based on miniublk
>> of blktest:
>>
>> https://github.com/ming1/liburing/commits/fused_cmd_miniublk
>>
>> Performance improvement is obvious on memory bandwidth
>> related workloads, such as, 1~2X improvement on 64K/512K BS
>> IO test on loop with ramfs backing file.
>>
>> Any comments are welcome!
>>
>> V3:
>> 	- fix build warning reported by kernel test robot
>> 	- drop patch for checking fused flags on existed drivers with
>> 	  ->uring_command(), which isn't necessary, since we do not do that
>>       when adding new ioctl or uring command
>>     - inline io_init_rq() for core code, so just export io_init_slave_req
>> 	- return result of failed slave request unconditionally since REQ_F_CQE_SKIP
>> 	will be cleared
>> 	- pass xfstest over ublk-loop
> 
> Hello Jens and Guys,
> 
> I have been working on io_uring zero copy support for ublk/fuse for a while, and
> I appreciate you may share any thoughts on this patchset or approach?

I'm a bit split on this one, as I really like (and want) the feature.
ublk has become popular pretty quickly, and it makes a LOT of sense to
support zero copy for it. At the same time, I'm not really a huge fan of
the fused commands... They seem too specialized to be useful for other
things, and it'd be a shame to do something like that only for it later
to be replaced by a generic solution. And then we're stuck with
supporting fused commands forever, not sure I like that prospect.

Both Pavel and Xiaoguang voiced similar concerns, and I think it may be
worth spending a bit more time on figuring out if splice can help us
here. David Howells currently has a lot going on in that area too.

So while I'd love to see this feature get queued up right now, I also
don't want to prematurely do so. Can we split out the fixes from this
series into a separate series that we can queue up now? That would also
help shrink the patchset, which is always a win for review.

-- 
Jens Axboe

