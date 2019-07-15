Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0955C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 15:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B500E20838
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 15:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfGOPlb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:41:31 -0400
Received: from ale.deltatee.com ([207.54.116.67]:55706 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbfGOPlb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 11:41:31 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hn36T-00067D-8v; Mon, 15 Jul 2019 09:41:26 -0600
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Stephen Bates <sbates@raithlin.com>
References: <20190712235742.22646-1-logang@deltatee.com>
 <20190712235742.22646-12-logang@deltatee.com> <20190715072148.GC4495@x250>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <91d723da-c1de-ae8b-d1c8-0a3bcee491db@deltatee.com>
Date:   Mon, 15 Jul 2019 09:41:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715072148.GC4495@x250>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, tytso@mit.edu, mmoese@suse.de, chaitanya.kulkarni@wdc.com, osandov@fb.com, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, jthumshirn@suse.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests 11/12] common: Use sysfs instead of modinfo for
 _have_module_param()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-07-15 1:21 a.m., Johannes Thumshirn wrote:
> On Fri, Jul 12, 2019 at 05:57:41PM -0600, Logan Gunthorpe wrote:
>> Using modinfo fails if the given module is built-in. Instead,
>> just check for the parameter's existence in sysfs.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  common/rc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 49050c71dabf..d48f73c5bf3d 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -48,7 +48,7 @@ _have_modules() {
>>  }
>>  
>>  _have_module_param() {
>> -	if ! modinfo -F parm -0 "$1" | grep -q -z "^$2:"; then
>> +	if ! [ -e "/sys/module/$1/parameters/$2" ]; then
>>  		SKIP_REASON="$1 module does not have parameter $2"
>>  		return 1
>>  	fi
> 
> But this now fails if the module isn't loaded yet. IMHO we'll need to check if
> "/sys/module/$1" exists and if it does check for
> "/sys/module/$1/parameters/$2", if not try modinfo.
> 
> Does that make sense?

Yup, will fix for v2.

Thanks,

Logan
