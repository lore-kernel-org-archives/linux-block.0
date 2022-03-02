Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D53DC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 15:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243359AbiCBPGg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 10:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiCBPGf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 10:06:35 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA3CCA701
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 07:05:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUt0wOp6rkelJlu1UC9XB5qtKyULaXctuZmmAAIEIGTJQQCmR+VirUEAaqPvd3jGrSefg8XnrG1AuL6TZTQV0yU/S6VJac297GNjDjlvgDEXp6aPg6LJ6xWYTgnQq+Y6WFTFd0cRLWb91Ho6wuaSoylI5qdJNkogxaAWWhkrMkyK6nXHeImSA3xmDBblFRkOg4I6tsW3DW6tsc24I57/S7YY9YXy46LLEejlW+GeE7JOpanPwWsPlBH8N7hOghFIF9N1Ej9aZQsbMVJDVTV9cgyIhDYwSa6Bxkwr3gWSVsHu/Ihv4e7+90hcWdWh9xJvMvwagxXO1+0tlqTkiQQ90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VExGLuDSRN+b42bFcENVBt2SUGtCvybUaDTAzHQGKY=;
 b=lSDRhTnRPomfDHHyuT+cmI8Of9/M8gSP/uKn5krofnaRhEX4WxT2jGIVvYNQ5iYVHCbrtLfqJ9a5+4FLkX4EMD8PHnH4Xi8kcpV+sRjdYG9zd5Cb2+UfcLF9pv7Jr6N+uqnmXScftU/VRR1UtDPdru2493jCEm9lRWU/1HU8+aIZt+kOmDp59C6qGMZ/0WmLEpfb1LH3u2Z3pTbVAMk7vRiuYEsPts2pQxmkv1JHDvsM0piA9Fb04KCxjxPRsfd1rVTugLykmxgguniqVBVKuk9MMpvMILWi5XVWrIXAm9tewFsWFafEG+sdFDVdGePXMRAINXlbSVHyttnmPrUL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VExGLuDSRN+b42bFcENVBt2SUGtCvybUaDTAzHQGKY=;
 b=scS6ZkOfdBu+9V/otuL6vB0HPOU9u6qylZY1nARekTjnQWe7oPq6jB9Aiy3MXWsRtV0Wz+vyWjU4h7nkYSdYIuiIhgUcpw2hVwJ6ZrrByVZKJ1KJnQi1Hu2UL6IhwAf0BX7AGj3jMNlMIj09Y02Gyi6GGFQeX0sBjad6hUOxZaUUlZMx6NhUYmoGb4n+hD5JXBHK85zFnEAjvM0mZqh9Bb1BhurEcYGuHvacNtDpXhghiOY5NKLsTr1jVOPPJovGspB0FtQKK1NCGcXlU1+8YwBqRhLvxhoOfiZmqIXNSqh8eFy0CIrYyOiraX64bej/fmgWfNjHv9IXkhp40OXObQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 15:05:49 +0000
Received: from BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3dd8:a647:627:f5be]) by BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3dd8:a647:627:f5be%6]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 15:05:49 +0000
Message-ID: <8fa47a28-a974-4478-23b6-aea14355a315@nvidia.com>
Date:   Wed, 2 Mar 2022 17:05:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Yongji Xie <xieyongji@bytedance.com>
Cc:     Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <CACycT3uGFUjmuESUi9=Kkeg4FboVifAHD0D0gPTkEprcTP=x+g@mail.gmail.com>
 <20220302081017-mutt-send-email-mst@kernel.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220302081017-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR08CA0014.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::26) To BL1PR12MB5032.namprd12.prod.outlook.com
 (2603:10b6:208:30a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0c6004c-2a74-4d2e-010e-08d9fc5e22db
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB234978060871504E40C2EB1EDE039@SN1PR12MB2349.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRxPdwnHX4CpdQhRqCLayKfbRGVVFHJT4Kg0uqh5rHw7dbvs3M/Zc47LDVNN8T0SBEUE0jNGVOtNLwtrt3r99977O7dVuDM5HSc4uoXFJwMXb2E4erYYh9U+AWnVd3F2ctrta+2JrmfudN93Cg4LcG4zYkiiUK8MBUOhu31MxmSdk4XnApXgSL/SldmyDB2n8suJJobVA9EHlGsYSQHnnT707xrRwDUzMOH449Q1/j19mrcdeowRraOGlvl0g2nXseiywipsxPhKQKCF5sHNK3wJGmMCE0C5rzqg6VJbSQCRHiD3OR+Y6mn+8hQjHiQ8PS1GSbuaTCVXwBVYscecGTp+3OunzFItmj/juGEcSx6CqFgiTdtbzwnB75IpNcFUofUG+vQ5axh8s86meEoSiQNicKC8ccZJIx2ogA8+A3RJeg0w4DR9VQQniloJHJBiT7siRjSID5OSK2jyL7StGB0aRv1YggfkxxXdM010DWcAdv2aH8HYMgE9ra/SerHyOOVMvDCI4b7RT9b4Mmg0ww6wevu8Ed3KsX9G/1nTjbWA+diPmDVlOlDDKMYA+majz3BmrIsJsUz7LzALsK98uaKvI00REEmIy+029fQAMfcSavo1bGDzllelQODFsP2YYN/FbrtmgkE7bp1itKVsPa9XF8qUM4uCXN5sXPBGEXrDvgLxwU534t3be4R6Z9vfjICIUD1RJ3dtvgtmHIsJQUMpRbSv98m1waS39QEShxKpXyLwrZDNzKN21CNMn18E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5032.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6486002)(508600001)(83380400001)(53546011)(6506007)(110136005)(54906003)(316002)(66476007)(8676002)(4326008)(66556008)(66946007)(8936002)(38100700002)(6512007)(31686004)(186003)(6666004)(86362001)(31696002)(2906002)(26005)(2616005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFPT1IzRUx2bGMwb0p4eWErVTczN1FGbC8ra1NWVjVhTjNOcTY0QmhiWEVz?=
 =?utf-8?B?a0JIclkzVEgvVHk1azZSbE5rYnZtbGVla2gvTzBvSjJjUTd2Mm9zWEoxS1Rl?=
 =?utf-8?B?Y0crRE53OFR2QUhsaHo2OXBtQ0lpVktLR3dCL1ovV2dxRnlxN1NhQVI5U1ZC?=
 =?utf-8?B?QitBelJwSStqL0g5RlF5YTNsaXRQTjNsdENQMi9lSUFEYXZVZ3JXa1RwNG1a?=
 =?utf-8?B?SEljOWV5aVpJL1cybGNEcXRTWlhFelV6UzN5WkIvRGlpb3lvSFNGdUxlSGQ4?=
 =?utf-8?B?azc5UGRmYXFJWlpDWm50NS84YVRmL2x0Sm9uTmk2VXduVWlCek5UT0EwZGQ5?=
 =?utf-8?B?bm9QWUFEYTJYY2hZZkl4ck9LalRlQUcyMlNpbE40NHJKUUlZZ1NSanhBbEdk?=
 =?utf-8?B?RENBTy9uV1Z3ZVIxRm9oSjc5RTUvZk9tY1FTR21GYmQ5QXM3eXVsVVlKOHZN?=
 =?utf-8?B?WDFSaGlVekhZV21xbWQ1UDgvb0dFYXFXUmNhdklPMWdhQ3k4elBVRGpPZVRT?=
 =?utf-8?B?NFNscmxKUGZGUk5Xb3ZWZ2FDUkhDSW00dzBtZnlEdVoyZ0h1U2NYRUtWQlJL?=
 =?utf-8?B?SG9qSk9oWHhMRW54YTRqMTNialh1aVB2ZmpvNytaajJPcFovWU54VzdCb0RE?=
 =?utf-8?B?QzMwWDEvblZ4c1c1cHZVcGNZQmJ5R1Q4bXFkVTBqSWJ3VFBNL2ExR3YxcFFZ?=
 =?utf-8?B?YUgxU3VlenhqVkhIR0VWZjdZenlHYzc5VGFRU0J5WGhlZGVWanpMUEtKU1l6?=
 =?utf-8?B?NEFtb0Y1RmZBQ3d2Vko1Z0wrbHNhSkM4RTh5RWxhL0kyTDNJSEdGSXRIT1RK?=
 =?utf-8?B?NnZNbDdWRitOYlltNm93YktaY1I5SnFraFdvbzArbkdrWXQ3eTI1UXRzSTR0?=
 =?utf-8?B?emx2VUduMjRsNnVCdjhjTmdjUmZ6QnFzbDU5V3Uya0dPSkp1YVhUdmtrdDZD?=
 =?utf-8?B?b0dwd29EdW1iZUo2UmRtanIzTzJWeGpvYWZLdlBnR2hzY1RCOC9jMmozTWtu?=
 =?utf-8?B?emZTUy9NTWc3ZklTbSt6TmV0UXljOG81U1BNYXhtQzJ0UjVvN3BBNmRhZlhH?=
 =?utf-8?B?dlRmcUN6cUU5ZWoraUE4a3FMMlZ3bFVpSXVNYjZldzNEaFdTWWxzREdSSzhX?=
 =?utf-8?B?NGpXOUZaQWFhcHREeTZaNDA5U09Ec1Q4M1RuTWtxcVlCVndDSEpudmtOK1la?=
 =?utf-8?B?NnRENkR3VVpYaE84WGpNQk1KdVg2YW9QL01GOThGVkNEYm1seDlFc0hrb1Ew?=
 =?utf-8?B?aDREekRCcUNBWlF6M2VlWHVHRlJsWXJUcDZveW5DamlrNDBlbC9JTzkzdGd3?=
 =?utf-8?B?SjkyUDY2ZVRZcTk1WWRGdWNQN1dqSHpYbTFjRCt4Z0JqeWMrQUJ4eGpIWHE1?=
 =?utf-8?B?ekQxRitwMWNUWUQ4bVdudnZPbXBNU0s1aGNHZE9CWnVERW85eU0rNjd6elpU?=
 =?utf-8?B?R2k4KzZBck5Lb1VRY0tPTDVXT01FZW9tZy9iNUM3Z0xBU1h3UW1iRlA1aUxB?=
 =?utf-8?B?SWl3WmRqSlJLeFNCYVp3dkkzalpMWS8zVUdycDZ0Rzd4bjU0Z2tYcHoxcHhh?=
 =?utf-8?B?Sk9yWEc2cm9FZExWd25kUDY5Yk5uMjRpTDMxSkhlUWtpZmRnVURBakczTHRE?=
 =?utf-8?B?ZVZZUG9ZZ2twK0JUVkIzejc3TjJ4U0gzdytNWkhDaHI4dklsNmxSTGhOc3hZ?=
 =?utf-8?B?TFE2YlB4d0d2WHRobmNJRDlTV2xsU2JkUGZzb3FrUlVPcWd6U3BVUUpMQzdP?=
 =?utf-8?B?VHZhUVRpSGhJZlJ5VCtsQUhJU2FSQTdmUUpLWDJhN3RvSUZPRHdMejErT0xQ?=
 =?utf-8?B?dFFYd0dPRUYxQ2krK2lyb2NjbnNyN0U3TzM1TlFCZDhXVlpwaVRXU1lrVTNV?=
 =?utf-8?B?VG1YVk55TTA4N1o2UFloKy9YMVoyazRDL1JFWVVIT3BJSTVKRHd3dFV0REZ2?=
 =?utf-8?B?a2lUelllWlByMHBIMVg2TGVlMjdYdVhpV1NFVmtsdFA5d3RDaEhZaytFa2xH?=
 =?utf-8?B?NFYyY0Z2RzFKRGVEZ2N4SFFsdGlibW1HVnZLb0tIWWExaDMyQkR0OEZaWlJW?=
 =?utf-8?B?Tk0wRkIyRWJ5UGNXTXRQdXN1S09RcWhvZnpzWnNMR1BZeEprWGVRYmVYWFNT?=
 =?utf-8?B?WEJhVVJtMldQZExJRnBOYWV2eE9CRThrQiswQXVjTVg3bWt6cWg2SlBmZi8r?=
 =?utf-8?Q?PFr73efwo02x0R0hisz2IqQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c6004c-2a74-4d2e-010e-08d9fc5e22db
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 15:05:49.5757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoKPa1HXHH6XdDj4j7DsdQ4f99Zls+AAEUQ3gcURIPWHttszZ1sVDBLwWS97f6FOCdVf6GXfpy0+ePrjzuv0Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/2/2022 3:15 PM, Michael S. Tsirkin wrote:
> On Wed, Mar 02, 2022 at 06:46:03PM +0800, Yongji Xie wrote:
>> On Tue, Mar 1, 2022 at 11:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
>>>> Currently we have a BUG_ON() to make sure the number of sg
>>>> list does not exceed queue_max_segments() in virtio_queue_rq().
>>>> However, the block layer uses queue_max_discard_segments()
>>>> instead of queue_max_segments() to limit the sg list for
>>>> discard requests. So the BUG_ON() might be triggered if
>>>> virtio-blk device reports a larger value for max discard
>>>> segment than queue_max_segments().
>>> Hmm the spec does not say what should happen if max_discard_seg
>>> exceeds seg_max. Is this the config you have in mind? how do you
>>> create it?
>>>
>> One example: the device doesn't specify the value of max_discard_seg
>> in the config space, then the virtio-blk driver will use
>> MAX_DISCARD_SEGMENTS (256) by default. Then we're able to trigger the
>> BUG_ON() if the seg_max is less than 256.
>>
>> While the spec didn't say what should happen if max_discard_seg
>> exceeds seg_max, it also doesn't explicitly prohibit this
>> configuration. So I think we should at least not panic the kernel in
>> this case.
>>
>> Thanks,
>> Yongji
> Oh that last one sounds like a bug, I think it should be
> min(MAX_DISCARD_SEGMENTS, seg_max)
>
> When max_discard_seg and seg_max both exist, that's a different question. We can
> - do min(max_discard_seg, seg_max)
> - fail probe
> - clear the relevant feature flag
>
> I feel we need a better plan than submitting an invalid request to device.

We should cover only for a buggy devices.

The situation that max_discard_seg > seg_max should be fine.

Thus the bellow can be added to this patch:

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c443cd64fc9b..3e372b97fe10 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -926,8 +926,8 @@ static int virtblk_probe(struct virtio_device *vdev)
                 virtio_cread(vdev, struct virtio_blk_config, 
max_discard_seg,
                              &v);
                 blk_queue_max_discard_segments(q,
-                                              min_not_zero(v,
- MAX_DISCARD_SEGMENTS));
+                                              min_t(u32, (v ? v : 
sg_elems),
+ MAX_DISCARD_SEGMENTS));

                 blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
         }


