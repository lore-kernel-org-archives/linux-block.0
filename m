Return-Path: <SRS0=SSPg=VX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5B8C7618B
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 13:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C762F22BF5
	for <linux-block@archiver.kernel.org>; Fri, 26 Jul 2019 13:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tds.net header.i=@tds.net header.b="eRGk1ybN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfGZN0S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:26:18 -0400
Received: from smtp.tds.cmh.synacor.com ([64.8.70.105]:31296 "EHLO
        mail.tds.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbfGZN0S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 09:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; d=tds.net; s=20180112; c=relaxed/simple;
        q=dns/txt; i=@tds.net; t=1564147576;
        h=From:Subject:Date:To:MIME-Version:Content-Type;
        bh=c4XJqzh+0S/Bu07gYj4dcWrvoRE=;
        b=eRGk1ybNA2atQTfUQnpB0xy7IHgIgdRERDKBKeGmLJhVWc9ju58WzYCkwUtRtV2m
        3k2VCzJyJse6eFP1GsIEYHSet8CBNu3OyLsvPlNy3V2HR5HSN6nQLDokoBW+fS7Y
        urMU7tU1nEP2aFn8bTJ1SbYKQ9EMeKc/fYOOqDEZHxafUP1MyXnPI73fkStqEZdV
        uK1LM5TRfKuONZDaG0G0m3Ardgk7DQAVs2XMtxOF1f/+KcRTEW5b9Hudvp7RB4KT
        YDxe+O48ruaNpPMBpZUXNkK34PtDzcHRxaMCtIeUh1K2+8ItbAnqL/4MOgHUFZMV
        YG6LdrZ+1arbyMTj1SiRFA==;
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.3 cv=epShMbhX c=1 sm=1 tr=0 a=QQ1z/TRHJLkw7QGu0419XQ==:117 a=QQ1z/TRHJLkw7QGu0419XQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=KGjhK52YXX0A:10 a=IkcTkHD0fZMA:10 a=nHvWMnLLnzEA:10 a=0o9FgrsRnhwA:10 a=C9He5zk_2WUA:10 a=BqQhp60dDaIf8CMFjd8A:9 a=QEXdDO2ut3YA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: ZGF2aWRjNTAyQHRkcy5uZXQ=
Authentication-Results:  smtp02.tds.cmh.synacor.com smtp.user=davidc502; auth=pass (LOGIN)
Received: from [69.21.125.220] ([69.21.125.220:54208] helo=[192.168.2.226])
        by mail.tds.net (envelope-from <davidc502@tds.net>)
        (ecelerity 3.6.5.45644 r(Core:3.6.5.0)) with ESMTPSA (cipher=AES128-SHA) 
        id FD/EB-22763-77FFA3D5; Fri, 26 Jul 2019 09:26:15 -0400
Subject: Re: fstrim error - AORUS NVMe Gen4 SSD
To:     Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, ilnux-nvme@lists.infradead.org
References: <fb510e33-5c81-6d62-fcde-a2989b3a1a8f@tds.net>
 <20190723021928.GF30776@ming.t460p>
 <4a7ec7aa-f6ee-f9dc-4a17-38f2b169c721@tds.net>
 <20190723043803.GB13829@ming.t460p>
 <20190724213054.GA5921@localhost.localdomain>
From:   davidc502 <davidc502@tds.net>
Message-ID: <906e532a-e17a-cd91-cdb6-3f8c76df6064@tds.net>
Date:   Fri, 26 Jul 2019 08:26:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724213054.GA5921@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On 7/24/19 4:30 PM, Keith Busch wrote:
> On Tue, Jul 23, 2019 at 12:38:04PM +0800, Ming Lei wrote:
>>  From the IO trace, discard command(nvme_cmd_dsm) is failed:
>>
>>    kworker/15:1H-462   [015] .... 91814.342452: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=7, cmdid=552, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_dsm nr=0, attributes=4)
>>            <idle>-0     [013] d.h. 91814.342708: nvme_complete_rq: nvme0: disk=nvme0n1, qid=7, cmdid=552, res=0, retries=0, flags=0x0, status=8198
>>
>> And the returned error code is 0x8198, I am not sure how to parse the
>> 'Command Specific Status Values' of 0x98, maybe Christoph, Keith or our other
>> NVMe guys can help to understand the failure.
> The 198h status code is still marked reserved in the latest spec for an
> NVM command set, so not sure what to make of it. I think we would have
> to refer back to the vendor.

Thank you  for taking a look at this. I guess my question would be if 
you have a vehicle in place to be able to refer back to the vendor?

David



