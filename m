Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBB2C00140
	for <linux-block@archiver.kernel.org>; Mon, 15 Aug 2022 16:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiHOQbU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiHOQbM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Aug 2022 12:31:12 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1B9140F3
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660581070; x=1692117070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CXyjCEkdqwCsAfu4st37lsVlUs22E4O97CKSx98wcPw=;
  b=NQ5HzS3hv+TsMWXhl6otZYGuLimwKvIGT85e9EFTKFLP93n9MiwjSmFp
   ragvp+zE7TVfDzvt+pgMSOtlc7qlPZCpko1/DBv9u5UqzmuSpEhZlIqdT
   S9E9xifVdfvVlGftC/rL7NLDUdRHB/v3pUN1xcZxI980WUzkykJMmdLZm
   iFj8wmieTlircnH/P7LygfFBAHgIZsNqYqztG8VVqwsYJd5YtJGIxDVmO
   EewL7BJj20+rVH9A32myZAbdFzcbkqLW96wbJQwuUO/90KtqsWcwatKSL
   fixh3hasb4wKdL9sxAk8hsgKttew4MFSPSyo5+JKPGCN0YgPDa6dRRSoE
   w==;
X-IronPort-AV: E=Sophos;i="5.93,238,1654531200"; 
   d="scan'208";a="213810145"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2022 00:31:10 +0800
IronPort-SDR: F2J7CftbQtybPQ4oB43K2zD5g2G8F5WtEneEhxhpffZIjklkAMvWLQZlg/ix+rdlJoZt0U7X6S
 B0BHiG4uEznUWeNYLx3aR5GMEzvJBNLTdEGVPWMrtbZ8xN/H1WcJRdXj41rzg5x0GxtEk1CDTs
 Lxl8119+R9mzskGCRPguiZwUld5YO++j1nKOn1TuyJJYE8s+0/anoJqGME4IlTQ5016M1NHPl3
 uiIhi8fb09GpEfZEFz8a4+oenZX+KOT2yljncEKh5d07KVGSpaQ/JI/uy7MXNwydGBVwX76698
 g+JIZSSQ7IUaqyG48jFTqgQx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Aug 2022 08:51:59 -0700
IronPort-SDR: b4OCjXWLmFYSnDtRsIcUTXZo5GzWHCTUUTk+btnGeaofk9ixPXaAU1nZ+HdmScpxfXOpZVeqJB
 8H7oozLFAFYjPFHSPsddYJ7A6+V01ECffM4zPA3lEkqhle6kDBTBctmN+NKaHIjbZXGJHx1Vxg
 b5XpVTPPy/NsU5II6q4a5AexSIY6scracJJIDa7sX8fy8Sb1nlazIe2Oh3YaOR1ulrHvcWCpD2
 OmT+yCuc+AonNc/3purjQ4SGIPraDRGuBzr7lZUqu6EWGRcdwJ9HhIO5/73TuMLXlziMnK8IX/
 gfo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Aug 2022 09:31:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M60CK65z3z1Rwnm
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 09:31:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660581069; x=1663173070; bh=CXyjCEkdqwCsAfu4st37lsVlUs22E4O97CK
        Sx98wcPw=; b=cfpnBj1r4cw0S424JInu0OB76L1HgQgIq4fWaD21LGMFme7N+xu
        JZ9cfTa6x/A4pnXnZVr6/8hT+6rEjEVoM5JnvSqoLdkZJC9NrO+oQydStcQp9GGr
        Ne2XlPrzzTj6mMkkaBd2ps9/dyOryUGpg8MgzXrdJqGshn0wCQ/UuwQwDJRvb74l
        +iethkUaVk1AdZabqZOvnNHTyMzPIqFym0c10oonbElJZjVtREX/nWd1i38o8fZI
        WRroQHyQLvBm52c+VeOzpG0vlbdj8sABSIFUSu4WLfpLyoR381eFzHK/s3beX297
        FHMLNdzznEikoMPBRkYCNEb6fRWqqx9InGQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id p_4j9FhLIlIH for <linux-block@vger.kernel.org>;
        Mon, 15 Aug 2022 09:31:09 -0700 (PDT)
Received: from [10.11.46.122] (c02drav6md6t.sdcorp.global.sandisk.com [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M60CK1PyKz1RtVk;
        Mon, 15 Aug 2022 09:31:09 -0700 (PDT)
Message-ID: <b46c033c-493e-1f1e-42b9-f62c188b2434@opensource.wdc.com>
Date:   Mon, 15 Aug 2022 09:31:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH] block: Submit flush requests to the I/O scheduler
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20220812210355.2252143-1-bvanassche@acm.org>
 <20220813064142.GA10753@lst.de>
 <f4e10a9a-313d-ce24-c610-f4e8d072d4f4@opensource.wdc.com>
 <09689854-b7b7-9a5c-cda7-f1f4de42b5fe@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <09689854-b7b7-9a5c-cda7-f1f4de42b5fe@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/08/14 16:44, Bart Van Assche wrote:
> On 8/14/22 10:13, Damien Le Moal wrote:
>> And writes to zoned drives never get plugged in the first place, scheduler
>> present or not.
> 
> Hi Damien,
> 
> I agree that blk_mq_submit_bio() does not plug writes to zoned drives 
> because of the following code in blk_mq_plug():
> 
> /* Zoned block device write operation case: do not plug the BIO */
> if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
> 	return NULL;
> 
> However, I have not found any code in blk_execute_rq_nowait() that 
> causes the plugging mechanism to be skipped for zoned writes. Did I 
> perhaps overlook something? The current blk_execute_rq_nowait() 
> implementation is as follows:
> 
> void blk_execute_rq_nowait(struct request *rq, bool at_head)
> {
> 	WARN_ON(irqs_disabled());
> 	WARN_ON(!blk_rq_is_passthrough(rq));
> 
> 	blk_account_io_start(rq);
> 	if (current->plug)
> 		blk_add_rq_to_plug(current->plug, rq);
> 	else
> 		blk_mq_sched_insert_request(rq, at_head, true, false);
> }

As far as I understand it, and checking the call sites, this is for LLD internal
commands only. And I think Pankaj has a good point for a fix to this one. Though
I would hate to see an LLD issue a write request though.

For f2fs, it seems to me that the problem is more with the code in
block/blk-flush.c where functions bypassing the scheduler are used for writes,
e.g. blk_insert_flush() / blk_mq_request_bypass_insert(). I am not 100% sure
though but that definitely looks very suspicious.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
