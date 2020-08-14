Return-Path: <SRS0=DF0J=BY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD08C433DF
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDF72065C
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1xDgQnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHNPqI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:46:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24687 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726652AbgHNPqH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 11:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597419964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKDr8V++g7/yk+XCg0clVAb/RZiCvMEN4qwAHQm7bcc=;
        b=b1xDgQnCUw+N+yZu1sdwsx3wrMhPMgzQt0SQXqkPE/UknLTmBFvTHg6JtRV66TbZjJ1ep0
        /2Vfg+fFr7ch0z+/J1S9ls6i2jljST4tPk6xC5USW8rp5R1+YpZgbjLeHcBcAdWPSoiapx
        GtbWFH4XbiJvLJrVpNbjBamGLT2Y6KE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-4pRitTtyPmOrbZHyR1dLXw-1; Fri, 14 Aug 2020 11:45:53 -0400
X-MC-Unique: 4pRitTtyPmOrbZHyR1dLXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A16C1005E5B;
        Fri, 14 Aug 2020 15:45:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 230F75C1BD;
        Fri, 14 Aug 2020 15:45:48 +0000 (UTC)
Subject: Re: [PATCH v4 7/7] nvme: support rdma transport type
From:   Yi Zhang <yi.zhang@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20200814061815.536540-1-sagi@grimberg.me>
 <20200814061815.536540-8-sagi@grimberg.me>
 <ffcaf9e2-083c-9601-16bd-054c3bd3b94c@redhat.com>
Message-ID: <af7154de-f2bb-fde6-4c6c-243711f971cb@redhat.com>
Date:   Fri, 14 Aug 2020 23:45:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ffcaf9e2-083c-9601-16bd-054c3bd3b94c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 8/14/20 6:49 PM, Yi Zhang wrote:
>
>
> On 8/14/20 2:18 PM, Sagi Grimberg wrote:
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   tests/nvme/rc | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index 3e97801bbb30..675acbfa7012 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -5,6 +5,7 @@
>>   # Test specific to NVMe devices
>>     . common/rc
>> +. common/multipath-over-rdma
>>     def_traddr="127.0.0.1"
>>   def_adrfam="ipv4"
>> @@ -25,6 +26,12 @@ _nvme_requires() {
>>           _have_modules nvmet nvme-core nvme-tcp nvmet-tcp
>>           _have_configfs
>>           ;;
>> +    rdma)
>> +        _have_modules nvmet nvme-core nvme-rdma nvmet-rdma
>> +        _have_configfs
>> +        _have_program rdma
>> +        _have_modules rdma_rxe siw
>
> start_soft_rdma can use siw or rdma_rxe(default one) module, but some 
> old distros may not support siw, but suppor rdma_rxe.
> how about:
> _have_modules rdma_rxe || _have_modules siw
>> +        ;;
>>       *)
>>           SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
>>           return 1
>> @@ -115,6 +122,9 @@ _cleanup_nvmet() {
>>           modprobe -r nvmet-${nvme_trtype} 2>/dev/null
>>       fi
>>       modprobe -r nvmet 2>/dev/null
>> +    if [[ "${nvme_trtype}" == "rdma" ]]; then
>> +        stop_soft_rdma
>> +    fi
>>   }
>>     _setup_nvmet() {
>> @@ -124,6 +134,11 @@ _setup_nvmet() {
>>           modprobe nvmet-${nvme_trtype}
>>       fi
>>       modprobe nvme-${nvme_trtype}
>> +    if [[ "${nvme_trtype}" == "rdma" ]]; then
>> +        start_soft_rdma
>> +        rdma_intfs=$(rdma_network_interfaces)
>> +        def_traddr=$(get_ipv4_addr ${rdma_intfs[0]})
The first rdma_intfs here maybe have DOWN state, which doesn't have an 
addr[1], I found similar check code here[2]
[1]
# echo $rdma_intfs
rdma_intfs:eno1
eno2
eno3
eno4
eno49
eno50
# [root@hpe-dl380gen9-01 blktests]# ip a s
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN 
group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     inet 127.0.0.1/8 scope host lo
        valid_lft forever preferred_lft forever
     inet6 ::1/128 scope host
        valid_lft forever preferred_lft forever
2: eno1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state 
DOWN group default qlen 1000
     link/ether 3c:a8:2a:21:7d:a4 brd ff:ff:ff:ff:ff:ff
3: eno49: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP 
group default qlen 1000
     link/ether 8c:dc:d4:1e:7a:78 brd ff:ff:ff:ff:ff:ff
     inet 10.16.203.27/24 brd 10.16.203.255 scope global dynamic 
noprefixroute eno49
        valid_lft 84814sec preferred_lft 84814sec
     inet6 2620:52:0:10cb:8edc:d4ff:fe1e:7a78/64 scope global dynamic 
noprefixroute
        valid_lft 2591978sec preferred_lft 604778sec
     inet6 fe80::8edc:d4ff:fe1e:7a78/64 scope link noprefixroute
        valid_lft forever preferred_lft forever
[2]
# grep -rin rdma_network_ tests/nvmeof-mp/
tests/nvmeof-mp/rc:93:        for i in $(rdma_network_interfaces); do
tests/nvmeof-mp/rc:235:        ) && for i in $(rdma_network_interfaces); do

>> +    fi
>>   }
>>     _nvme_disconnect_ctrl() {
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>

