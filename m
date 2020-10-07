Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2683DC4363D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 00:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF8C20739
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 00:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="c/GXW+u8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgJGANh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 20:13:37 -0400
Received: from ale.deltatee.com ([204.191.154.188]:32966 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJGANh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 20:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eYFnsTNV0pXGQumm+nqU2TNbmz7lOpEXm7qb8I/w0lQ=; b=c/GXW+u8o1AM2KEKc7MYJzCiPw
        eJ7MUQ4HAgarJHK+8kQ+sUs9iA6/8QNLZsq6zEF/gkhvIhD0MJ2wULJkvDl29UC589Njlg7qaYAok
        nB5K9nCja1NwF+12oHFqo80dGSQbvbsETf5CoMpHtChLSapQS8Tew70if3fCCZnc3efxLvPWnnWoV
        uuRNoHiw9xRVxbUbny0W/Gt77sCcQfAaW2hhuFGkfIYwhMXz9M1AFxdsPI2Ka20YX/5SXcfkQm33F
        fUol7kCrTM06e536K47DKAIWiLYz+PvLKIIkZKK0re0/K8iTd4pvr0Bi2Ztw8K7na+L50AH6MLr77
        ofW8Smsg==;
Received: from [172.16.1.162]
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kPx5J-0007C8-Ug; Tue, 06 Oct 2020 18:13:34 -0600
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Stephen Bates <sbates@raithlin.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-6-logang@deltatee.com>
 <BYAPR04MB49654DCBAD729B05759EB6FF860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e7bdf462-c86d-f248-58f4-d9d41b2bd343@deltatee.com>
Date:   Tue, 6 Oct 2020 18:13:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49654DCBAD729B05759EB6FF860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, osandov@osandov.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 05/11] nvme: Add common helpers for passthru
 tests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-10-06 6:02 p.m., Chaitanya Kulkarni wrote:
> On 9/30/20 12:01, Logan Gunthorpe wrote:
>> Add some simple helpers to setup a passthru target that passes through
>> to a nvme test device.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  tests/nvme/rc | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index dfa57a299625..1ea23308a3f7 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -73,6 +73,17 @@ _require_nvme_trtype_is_fabrics() {
>>  	return 0
>>  }
>>  
>> +_test_dev_nvme_ctrl() {
>> +	local dev
>> +
>> +	dev=$(cat "${TEST_DEV_SYSFS}/device/dev")
>  can you initialize dev this at the time of declaration ?

Yup, will fix.

>> +	echo "/dev/char/${dev}"
>> +}
>> +
>> +_test_dev_nvme_nsid() {
>> +	cat "${TEST_DEV_SYSFS}/nsid"
>> +}
>> +
>>  _cleanup_nvmet() {
>>  	local dev
>>  	local port
>> @@ -257,6 +268,27 @@ _remove_nvmet_subsystem() {
>>  	rmdir "${subsys_path}"
>>  }
>>  
>> +_create_nvmet_passthru() {
>> +	local nvmet_subsystem="$1"
>> +	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> +	local passthru_path="${subsys_path}/passthru"
>> +
>> +	mkdir -p "${subsys_path}"
>> +	printf 1 > "${subsys_path}/attr_allow_any_host"
>> +
>> +	printf "%s" "$(_test_dev_nvme_ctrl)" > "${passthru_path}/device_path"
>> +	printf 1 > "${passthru_path}/enable"
> 
> can you please echo in general and printf only when it is needed ?>
> I know existing code is a bit inconsistent I'll send a clenup to make it
> uniform.

Yes, I agree. I will it fix in v3.
Thanks,

Logan
