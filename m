Return-Path: <SRS0=vwZl=3Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D191BC3524A
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 03:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EE72087E
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 03:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OYx9ZrNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBDD5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 22:57:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49512 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBDD5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 22:57:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0143vb72048965;
        Tue, 4 Feb 2020 03:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=o/iBqdRpOFc/3gJA2AIa0ERyso1I5BptL0zbyt4m2Xw=;
 b=OYx9ZrNVPOoP3oSicSRJoTCIqtdkPlpsSs7t3Ity7loqVlfLCNcBilMVfvVOAYSSQdRd
 9qQJgvauu22FS9Lv2gB13de5xG1eAtBvZ9uNT0soPaIk57D2eR3TCbP2B9VPApGzMOUS
 S7Sk5lP3DmVKENgg4AL5rf6+Hg4mrbMphcMOy1Z8PJ0fnfhVgLMPzUEFi8figlOe6hGL
 wLzJDMnl99SZQR73KP8Hpyg6yY3nE4NSaWr9lXgHlT/7K45EClaELHUgoK3QmEETdALu
 MHFch8+ez7ogRm8GTqnhVqRDukvt6Z3ehL+VurvM0ptN5xtO1lYkrPBOisiLfeK1zpC4 ZQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xwyg9g2px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 03:57:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0143sDMZ152423;
        Tue, 4 Feb 2020 03:57:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xxvuqn510-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 03:57:35 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0143vYHY017366;
        Tue, 4 Feb 2020 03:57:34 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Feb 2020 19:57:34 -0800
Subject: Re: [RFC PATCH] dm-zoned: extend the way of exposing zoned block
 device
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <20200108071212.27230-1-Nobody@nobody.com>
 <BYAPR04MB5816BA749332D2FC6CE3993AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <c4ba178c-f5cf-4dd1-784b-e372d6b09f62@oracle.com>
 <BYAPR04MB5816B2967735225FB37D627BE7000@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <bc772b99-b629-1979-7ce9-b685242b86d0@oracle.com>
Date:   Tue, 4 Feb 2020 11:57:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816B2967735225FB37D627BE7000@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040028
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/3/20 11:06 PM, Damien Le Moal wrote:
> On 2020/02/03 21:47, Bob Liu wrote:
>> On 1/8/20 3:40 PM, Damien Le Moal wrote:
>>> On 2020/01/08 16:13, Nobody wrote:
>>>> From: Bob Liu <bob.liu@oracle.com>
>>>>
>>>> Motivation:
>>>> Now the dm-zoned device mapper target exposes a zoned block device(ZBC) as a
>>>> regular block device by storing metadata and buffering random writes in
>>>> conventional zones.
>>>> This way is not very flexible, there must be enough conventional zones and the
>>>> performance may be constrained.
>>>> By putting metadata(also buffering random writes) in separated device we can get
>>>> more flexibility and potential performance improvement e.g by storing metadata
>>>> in faster device like persistent memory.
>>>>
>>>> This patch try to split the metadata of dm-zoned to an extra block
>>>> device instead of zoned block device itself.
>>>> (Buffering random writes also in the todo list.)
>>>>
>>>> Patch is at the very early stage, just want to receive some feedback about
>>>> this extension.
>>>> Another option is to create an new md-zoned device with separated metadata
>>>> device based on md framework.
>>>
>>> For metadata only, it should not be hard at all to move to another
>>> conventional zone device. It will however be a little more tricky for
>>> conventional zones used for data since dm-zoned assumes that this random
>>> write space is also zoned. Moving this space to a conventional device
>>> requires implementing a zone emulation (fake zones) for the regular
>>> drive, using a zone size that matches the size of sequential zones.
>>>
>>> Beyond this, dm-zoned also needs to be changed to accept partial drives
>>> and the dm core code to accept mixing of regular and zoned disks (that
>>> is forbidden now).
>>>
>>> Another approach worth exploring is stacking dm-zoned as is on top of a
>>> modified dm-linear with the ability to emulate conventional zones on top
>>> of a regular block device (you only need report zones method
>>> implemented). 
>>
>> Looks like the only way to do this emulation is in user space tool(dm-zoned-tools).
>> Write metadata(which contains emulated zone information constructed by dm-zoned-tools)
>> into regular block device.
> 
> User space tool will indeed need some modifications to allow the new
> format. But I would not put this as "doing the emulation" since at that
> level, zones are only an information checked for alignment of metadata
> space and overall capacity of the target. With a regular disk holding the
> metadata, all that needs to be done is assume that this drive is ion fact
> composed solely of conventional zones with the same size as the larger SRM
> disk backend. The total set of zones "assumed" + "real zones from SMR"
> consitute the set of zones that dmzadm will work with for determining the
> overall format, while currently it only uses the set of real zones.
> 
>> It's impossible to add code to every regular block device for emulating conventional zones. 
> 
> There is no need to do that. dm-zoned can emulate fake conventional zones

Oh, what I intend to say is it's impossible adding "BLKREPORTZONE" to regular block device driver.
We have to construct fake zone information for regular device all by dmzadm, based on current information
we can get from regular device.

$ dmzadm --format `regular device` `real zoned device` --force 

> for the regular device (disk or ssd) holding the metadata. Since
> conventional zones do not have any IO restriction nor do they need any zone
> management command (no zone reset), dm-zoned only needs to create a set of
> struct dm_zone for the emulated zones of the regular disk and "manually"
> fill the zone information. This initialization is done in dmz_init_zones().
> Some changes there to create these struct dm_zone and all the remaining
> metadata and write buffering code should not need any change at all (modulo
> the different bdev reference). Do you see the idea ?
> 
> The only place that will need some care is sync processing as 2 devices
> will need to be issued flushes instead of one. The reference to the
> different bdev depending on the zone being accessed will need some care in
> many places too, including reclaim. But dm-kcopy being used there, this
> should be fairly easy.
> 
> Adding a bdevid (an index) field to struct dm_zone, together with an array
> of bdev pointers in struct dmz_dev, should do the trick to simplify
> zone-to-bdev or block-to-bdev conversions (helper functions needed for that).
> 
> Thoughts ?
> 

Thank you for all these suggestions.

Regards,
Bob



