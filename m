Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2303C4321E
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 23:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiK1Xfp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 18:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiK1Xfp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 18:35:45 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B17F32B91
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 15:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669678544; x=1701214544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WTQBEO2+NdsnQYoTo1EkqH9Qza1ICK65kT5KI3Mzq1k=;
  b=L1A1uC+CFp/86OnOpeYG41C4giMrOKlfWSSM7lzMb34cy7O+ullS4TbN
   LxeAMZPdS5NkNbhJu0nb++UNou5p6nqRhiwmEMIDPBIgRiZzcvligP1Yz
   eq983Lm2oSbfMhp8zaUkWXPQjlebN7tRF+iXxst37oo04jpKgf1Ki2QSH
   ClAaw5vWpwZnoyR13zNGFSfXpz/TY9jTIk7J9YbbCv/MF262jZAaroTJt
   fMYu13ShR5lgNNaNQWm8o+7pI8kmiTCKy0JNbkS6k8fkL8U/X6P0qFjun
   OrsJpEA7hRIpd9EipLNZ+RZKKIBJB9OqnDys+317xdEqihjasVMDf+moq
   A==;
X-IronPort-AV: E=Sophos;i="5.96,201,1665417600"; 
   d="scan'208";a="217390887"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2022 07:35:42 +0800
IronPort-SDR: 2hv8GCmhbWbVEeUtjo77pW5YS14gHCr2Uin7bQkqqztagzquGKBbgIR9rkVmcxAeJFFCETR7aR
 BCLDoqy7BpfCNfDrQlQV7spQxLHdt2Nhye2FkBmu9625yEWghOs4tG2r0f6vxqlBzwBVKQ9TVW
 PdGzNMoOLaCrW2vUzreinf6e/W3b/WOnMA6w9El2nAxV2eQiS+h+Hk1W22FdpKVEFuDkFrRflq
 NAHh8GSqN0qIwP3QwLAI2a4bmJKuQrE5QV3hiSE9DRGzNy5yGjtjwxIK1KRD7HSetFjSxKqqGH
 CbI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2022 14:48:39 -0800
IronPort-SDR: wcjEGHcp0o2p9ElfI+M5p1qAImx2RZD7/czULKazvkOliaa1wsE9ZQDjpJZh0ZZaUVwEViKB+q
 QQRuRVGhcXjA5WxWCj9YJuTB9wF+vto4OivRWPSGhYF6d1KJy9YPQpJa8eBs2Oneb4Z+gPivVp
 fPCh5HrlPPZeBNHN+JvvA9etVYd1JEGySoAqdMZMfU50vd97kPU8euS5jVLmisB1T4g4BvGijm
 gDslO3L0Y84aylmPwHHtzZStVVSFpnPjICG/2XqV0Zw3CyvmfpeeE7ohiYcXxyeTc3lyBIibRH
 l7w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2022 15:35:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NLhfk4pQTz1RvTp
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 15:35:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669678542; x=1672270543; bh=WTQBEO2+NdsnQYoTo1EkqH9Qza1ICK65kT5
        KI3Mzq1k=; b=SQlzdEBoT7LquqRz5QRbCD9GdZI2A9CaKJQX+9T1UnOt7x76EP9
        aMmC8GCeAY9dYDIZC+rNCzYg4v0IcDHo69C6YyQ9LVxnBCdPwz66RJfhDn9u8ara
        m3CzQ7Yf+DUezf/k9+3Q/B/mXnuERNE/2AbhMTBZJoLYl0BADIdys/9seZugNRfH
        CALfeHKbwvAhBTJC9KxmGWu1FyslxsjoBajITUyNJaTWdZ8bQ4nmxUWSJSBDShcg
        tycwUJMP3w3tV+U+MlT5j2nPGQlqbd+oQrN4Y81fjzihUkLqVWKwkokG2Qrd/fDI
        es/pENZNvXtrp4UUoaxWhqrM5t5OgRdOj0g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rkJZ-4exXcRp for <linux-block@vger.kernel.org>;
        Mon, 28 Nov 2022 15:35:42 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NLhfj54Vpz1RvLy;
        Mon, 28 Nov 2022 15:35:41 -0800 (PST)
Message-ID: <8dcb9649-c0d0-40e3-319b-1e1c177b688b@opensource.wdc.com>
Date:   Tue, 29 Nov 2022 08:35:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] block: fops: Do not set REQ_SYNC for async IOs
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20221126025550.967914-1-damien.lemoal@opensource.wdc.com>
 <20221126025550.967914-3-damien.lemoal@opensource.wdc.com>
 <Y4TS7BDDQEn+uusB@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y4TS7BDDQEn+uusB@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/22 00:25, Christoph Hellwig wrote:
> On Sat, Nov 26, 2022 at 11:55:50AM +0900, Damien Le Moal wrote:
>> Taking a blktrace of a simple fio run on a block device file using
>> libaio and iodepth > 1 reveals that asynchronous writes are executed as
>> sync writes, that is, REQ_SYNC is set for the write BIOs.
>>
>> Fix this by modifying dio_bio_write_op() to set REQ_SYNC only for IOs
>> that are indeed synchronous ones and set REQ_IDLE only for asynchronous
>> IOs.
> 
> Well, REQ_SYNC is used for I/O that some is actively waiting for,
> which includs aio/io_uring I/O unlike buffered writback.

OK. But then the semantic of REQ_SYNC should really be more clearly
defined. Always setting it for bdev direct write IOs regardless of the
iocb type is telling me that we should not need it at all, especially
considering that for bdev direct IO reads, it is the reverse: REQ_SYNC
is never set.

> So I don't think this should be changed.

OK. But then what ? Looking again at the block layer use of REQ_SYNC, I
do not see anything super relevant. wbt_should_throttle() use it to
detect direct writes. Some other places set that flag but it does not
seem to actually be used/tested anywhere. What am I missing ?

-- 
Damien Le Moal
Western Digital Research

