Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89252C64ED6
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 21:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjB0VmH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjB0VmF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 16:42:05 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AEB1ACC5
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 13:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677534124; x=1709070124;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E16+HmI91qcq4n85XyiBcodRpHC0xN8mBwf0nq/L8Kk=;
  b=pRcmi19n1OsG7Q9RgrfjuXphXzxRn+ium94K6fBI6DJZ4O8km25Ebxc6
   4R5qGGXmB81u02x1mttDt6offMPJKEQCxHMHYHnxWMS1etdq11mXP2bau
   J4dUZoxpMWfOcgOwLVSIumOk2qr0aQAnm/+G92en1kpHYfr78L4rM83fQ
   u87/SmWMDrqGI2Z+CafIr1II6II44PwtVdfbMYKoqscRBMFWL3HNNEGYz
   BgbcwmdF1BJGw70BCCHZPLl8lkVDa9J19lcXRhzmYSkZ8C1xQ2C9+8wYt
   snXK9QIZiLHUvEHhry5xzb6aexfNQ9cgKZ1LFHFr86e0w9k72TKzDy7rM
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,220,1673884800"; 
   d="scan'208";a="328673532"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2023 05:42:04 +0800
IronPort-SDR: 2EM43Mx+nCHN+N3nxaCzPoAnvi8Jz8cNC6CQojPE6S2VXv6caixI1+eeEl4Fznj1rfZ50lq4UE
 i4ZUkiET8a8G1DUVuUEPB+pkzFii/bzdKCD7Snecnxcf4P6YhdwUK+I+lDTFggmYA4WNeEOfWF
 3EfEGnPKJgwUytQiuPPXGqm/K55B+dGhop3SG4LsDHGMAc+cx50kgDjtvB9w1oxm8pzfM8sftv
 IKlp2K9f8gKqoRutYh2LeWC0x2/eDCsOxFEwVgzRYMEbcqcbZObYLKEL7QKG8EtQMP4865SS+a
 m2I=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2023 12:53:11 -0800
IronPort-SDR: uRN8CihV9r5ye6IiQJdeaq+XkKucYb434/YxuSeUR0IiqhLO+wW7Ijzg/r+HatoBAepDHwamNc
 oEkjSdiQ3k06MTBLL/xYdWfVbM0bX9EfnXArpvIFrohgExD84UyoexqlKSzxWyEux9HxdwOy9e
 w3rWY31d2EylhzQy1hZTNoE1bh+Av9DAYsGe0a7EhgYYfFcvbDP2pPaxNGkit8uJYXKBQiotWS
 dKGF2ztV+gR1i1w75GX9ggEgj8Hyr+Aa5zWIA2Q+qCECjyG8S0aaK/rFyKHOHLTXxMt4mEBEkj
 0dE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2023 13:42:05 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PQYqb5qfZz1RwqL
        for <linux-block@vger.kernel.org>; Mon, 27 Feb 2023 13:42:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677534123; x=1680126124; bh=E16+HmI91qcq4n85XyiBcodRpHC0xN8mBwf
        0nq/L8Kk=; b=ZDIJKxZC/XiBEFR1lU5bIqmUDLpKvv3mVUtzX+l+JOr1/H3c6o2
        bgjlE20HVQFCtxvgkyjUyzSnC+AFx6ptm/8HIXD7hcxLI/U4RNA0nd70r/YOuXsu
        CilEATzEr28n12S7pkjSLWEQJN4NYDeM6QwR/aRKUz8JJ3XLWTCGV296TWQBOoN7
        SgIgpfNN09SDg3s1N3uLHwyKLOWMCRjJnJroz0gXnFMFRYsq4g1/ro001OvSJZ2d
        1yPNrEFKtKf38tyW6eIEl8FBnB9WN+G/f8PQ7G3rSIeOOIngIHdr9sTE7N5bJlER
        L+dvopUXf7Z3pnIboSAdeaJiL9pGMoexDZA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2zXXB9V_ciel for <linux-block@vger.kernel.org>;
        Mon, 27 Feb 2023 13:42:03 -0800 (PST)
Received: from [10.225.163.44] (unknown [10.225.163.44])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PQYqY2qRZz1RvLy;
        Mon, 27 Feb 2023 13:42:01 -0800 (PST)
Message-ID: <9e1d83e8-e382-59a6-3283-e4f4a5dc7f56@opensource.wdc.com>
Date:   Tue, 28 Feb 2023 06:42:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "lsf-pc@lists.linuxfoundation.org" <lsf-pc@lists.linuxfoundation.org>
References: <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
 <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
 <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
 <Y/Yscr82hqdKl1Hw@kbusch-mbp.dhcp.thefacebook.com>
 <561afa67-04d0-c675-6bbb-048313da152b@grimberg.me>
 <73b4dd39-9ce8-9b55-8a1d-06865f3bde32@nvidia.com>
 <Y/lpmrwuehnsWmmR@kbusch-mbp.dhcp.thefacebook.com>
 <0fe59301-65e6-d8a9-033e-0243ad59c56b@opensource.wdc.com>
 <316431ed-1727-7e80-2090-84ac5b334f74@grimberg.me>
 <3ea301b1-c808-ce08-8ec8-3a631b385fb9@suse.de>
 <Y/zsE9i7012Ivwe1@kbusch-mbp.dhcp.thefacebook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y/zsE9i7012Ivwe1@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/23 02:44, Keith Busch wrote:
> On Mon, Feb 27, 2023 at 06:28:41PM +0100, Hannes Reinecke wrote:
>> On 2/27/23 17:33, Sagi Grimberg wrote:
>>>
>>> I'm not up to speed on how CDL is defined, but I'm unclear how CDL at
>>> the queue level would cause the host to open more queues?
> 
> Because each CDL class would need its own submission queue in that scheme. They
> can all share a single completion queue, so this scheme doesn't necassarily
> increase the number of interrupt vectors.
> 
>>> Another question, does CDL have any relationship with NVMe "Time Limited
>>> Error Recovery"? where the host can set a feature for timeout and
>>> indicate if the controller should respect it per command?
>>>
>>> While this is not a full-blown every queue/command has its own timeout,
>>> it could address the original use-case given by Hannes. And it's already
>>> there.
>> I guess that is the NVMe version of CDLs; can you give me a reference for
>> it?
> 
> They're not the same. TLER starts timing after a command experiences a
> recoverable error, where CDL is an end-to-end timing for all commands.

Note here that with the current T10/T13 CDL definitions, end-to-end actually
means from the time the command is received by the device to the time the device
signals the command completion.

That does not include the transport & host adapter queueing (if there is an
HBA). And I guess this is the issue at hand for fabrics: how to integrate the
transport times. I guess the CDL descriptors could have one additional limit for
that, but then the duration guideline limit definition would need to be tweaked.

-- 
Damien Le Moal
Western Digital Research

