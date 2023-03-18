Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B78DC74A5B
	for <linux-block@archiver.kernel.org>; Sat, 18 Mar 2023 14:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjCRObw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Mar 2023 10:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCRObw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2023 10:31:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884C225E00
        for <linux-block@vger.kernel.org>; Sat, 18 Mar 2023 07:31:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o11so8111075ple.1
        for <linux-block@vger.kernel.org>; Sat, 18 Mar 2023 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679149906; x=1681741906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CcTCSKyoFSR4JaDnvBESywdYcTmjXT52y248CjSjOE=;
        b=e+6lmIPaiRX0CqIUttFJBrndWQYiZ0ZxwNhH4+ucCoV89Z3i1NjHIfUb0bYL95xv+w
         GhK8KVI/xxrqtPDMv0TvYy3jMsJfBZjchEtJCrAtthjeqvej6tDcmFVTDXk9n7/Dyf3C
         yvNVYaxV/bpiDKmDbdro76BjAuB34d8nN/ePhj32dKBU3JwtdxDzoxN8fSuyKHijQXyP
         zcUVET2SuKvBdn1MKwc3bMwGX20LUJIZU4YKa1HOiAQ/ehshWaCGgr3/s91bJBvLEVhN
         eNi5o7QWOWvC2l8m4HohiZkY1qkfwTSTchjyvR3TMLrCjplQCtD+9ZyR8BzzEWJCXidr
         Vdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679149906; x=1681741906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CcTCSKyoFSR4JaDnvBESywdYcTmjXT52y248CjSjOE=;
        b=Oh6MsnOiSDzi1nE2dRHVHBkbuy7GLDDpbJyG4aAGMD9NQMbotiaPEw2xOiy75VVzfv
         ukFvsXutBcUNMTZHDaCZwskN47FtQrxCXkG/P/xon5xF0EhCxXjfHmuuK4K/D8CtD0GB
         UVF0LENPGtpLGgprUQMGQ2ncA9FsOW7qSD/cElvPR81tXawq/XNaQuMhgJj4jbqf/OzA
         Ut4BFyagITgC3T4GfISAmYLCSKaq6R+8T5RhHPFRrlSjboevWyL74I+frRCDqg+4saY+
         uJ2jMUE9Pj3USwtsZIwHutVOUf99fxJJ6Gkco/lPd4KTuRAlVuMQAUkxWOJ7zaSw2I0D
         RYLg==
X-Gm-Message-State: AO0yUKWXOw0Evb2Ub7Vku2B3PLkNFG3maisGysNwUKvgykiHqyOGVs36
        LV6GWL7lt8oQ2wmWsJwC3fvaeQ==
X-Google-Smtp-Source: AK7set8ytrG+LBNVevvm4pzwJdQiHhcnJ+fWa3hzo1NRtfYikvYqTjsTD7cMsWTGyBv56961LKmzDg==
X-Received: by 2002:a17:902:ef8d:b0:19d:1e21:7f59 with SMTP id iz13-20020a170902ef8d00b0019d1e217f59mr13557969plb.0.1679149905984;
        Sat, 18 Mar 2023 07:31:45 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jw20-20020a170903279400b001a0428bd8c4sm3358198plb.289.2023.03.18.07.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 07:31:45 -0700 (PDT)
Message-ID: <e92b121c-553a-b699-11ca-746ff2522d7e@kernel.dk>
Date:   Sat, 18 Mar 2023 08:31:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3 02/16] io_uring: add IORING_OP_FUSED_CMD
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20230314125727.1731233-1-ming.lei@redhat.com>
 <20230314125727.1731233-3-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230314125727.1731233-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/23 6:57?AM, Ming Lei wrote:
> Add IORING_OP_FUSED_CMD, it is one special URING_CMD, which has to
> be SQE128. The 1st SQE(master) is one 64byte URING_CMD, and the 2nd
> 64byte SQE(slave) is another normal 64byte OP. For any OP which needs
> to support slave OP, io_issue_defs[op].fused_slave has to be set as 1,
> and its ->issue() needs to retrieve buffer from master request's
> fused_cmd_kbuf.

Since we'd be introducing this as a new concept, probably makes sense to
name it something other than master/slave. What about primary and
secondary? Producer/consumer?

> +static inline bool io_fused_slave_write_to_buf(u8 op)
> +{
> +	switch (op) {
> +	case IORING_OP_READ:
> +	case IORING_OP_READV:
> +	case IORING_OP_READ_FIXED:
> +	case IORING_OP_RECVMSG:
> +	case IORING_OP_RECV:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}

Maybe add a data direction bit to the hot opdef part? Any command that
has fused support should ensure that it is set correctly.

> +int io_import_kbuf_for_slave(unsigned long buf_off, unsigned int len, int dir,
> +		struct iov_iter *iter, struct io_kiocb *slave)
> +{

The kbuf naming should probably also change, as it kind of overlaps with
the kbufs we already have and which are not really related.

-- 
Jens Axboe

