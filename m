Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EF3C433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 09:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiCBJwZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 04:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240704AbiCBJwW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 04:52:22 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0868CE09C
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 01:51:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rjt4FF4lqK2m+WS4DBfpELiB0TDa3D6LAEz2jQ7vO6+BkwFYnJpVg/X1yl1w6hOR01ofhMvjTJpMLCbIMYIU5E7MPIUiW03fkv+x1plQfyOHqQ3mxdoTqeMLIpKANi+suH4gNJ3h6zhDzMR7EDEDpiWSxj4X8x4L3Q7eb0ESpV1SyFmm/rpR++1DCavkoMK+BuyZujpab4rc93KLpNhIcCqmhe+rGy5SnHWSnT/dbQvGyxjOEwTxRS0hvc8as0I6yIgQGKCLuEGJb+2O3hZPv5svsVPRCr6r8lWUq0gfky2aGQ5hMESZ07BkKFr1VxfU2z8VFHdw3GTRBIOgkXbOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ4ziZQ967d7onX5VQVcSH4ndqR9fFEOaDPjU27tlZ8=;
 b=bCnofN3mcz5gbHN/QAMZBJAn1par5hMjxoCXkQjEgMpTOlrNKz4eBDt24ZZBxMH4RGjF0opsIoAdH9xyxk9kZlzLtz+EMQelx3RrutuJxorAG2WP9mKlWzmw68+FSZxr+6tbsZ/uepw5o1L3yroE8OWacizQzq9yyQd6ssN+nETGTfQR6dhGrVHbPsF1hL9Hqgf4dg2MHagnczH6pLgACwMEWFWu3QpXlJHfnvnJQB/Vq7g0G4l4FutRr9x/sMX2eIueh/jR7bDiMTUM0N7WxtAItyknW57P+WSV5A4IJgi0z7faY7V1GADN4vYjRnjO8u/5EuUxl2hJ5aDSvtxEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ4ziZQ967d7onX5VQVcSH4ndqR9fFEOaDPjU27tlZ8=;
 b=qLUy8tSdzzQMdpvkCP59dSNh17JERF9GRRKtvu3l3vUyu9GZQkhLQETeg7Bk3iafAQ57b1zgIfDGZOV8P2/cFErptLtoxXvdo1hrVRD/s/vWRBDxNf/cmkd2Cg3BM4EG2Wc3JSLwR5JqVK9f0EKiAh5HQpCRyTUrj7S06T4mfyXqfNR1BILTtCIm6JIw7y16GlpmqNbphM0I+Fz8Te1H+Dfd6jbbENHycnTG9QfVfYh7Eww/+7CK8ALW7y/9ZPEsyV6cvHhyvWb15fCjKPkKFdgRwCGUGAhthdKj3DKmIUcUOhp6ZZFMI8QZnhLWN/U6GNP4yhhTMH1oLJo8Wt5lHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MWHPR12MB1519.namprd12.prod.outlook.com (2603:10b6:301:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 09:51:36 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%6]) with mapi id 15.20.5017.026; Wed, 2 Mar 2022
 09:51:36 +0000
Message-ID: <85e61a65-4f76-afc0-272f-3b13333349f1@nvidia.com>
Date:   Wed, 2 Mar 2022 11:51:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, axboe@kernel.dk, hch@infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220301104039-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P193CA0060.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::37) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 706b98d6-df03-43df-0caf-08d9fc323d8c
X-MS-TrafficTypeDiagnostic: MWHPR12MB1519:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1519AD22FB80EBF7B80B0E62DE039@MWHPR12MB1519.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lEM8nZcNjJhFeB5Mh1+yHSC32Jyl1AeJ2U3ixu6OuWdXyQ8brXFOKcI1ET/tue93szaZar0VLCQegbBRakA+r33baWGaqn2wLsJIoNk0QDJcQ3E7FCQZFHCk2DAi8f9PoOUOMKHim4bo4A5socjEhbV0/95dk2qb8dlNw6Oa6jn+4UEJ1SBHHQdAuApRO/lNbXONj8wdJxKjTOu9lJhW/QA7iw1Ha2uqeilparJS02vzGj34qhQMvsHDz91bB0PHducnApkikmcv5Fd5xIgf+HEp8hmbPmmo2LnzMIzdpACNx+HGBT1e7Yyq1ZzemYnTWTM0tPOqcYUxC1SUi2Wmkz9uAv3dZVjr5iSS6RAjKSGSMS4JsH7skHBl68AszcoR/SsKs2M+emTmlnrUPNn4B1Vhfor1Z60aDkJU1EosGS9z33MkROrQEfoF4X/skbTWNmyUK5OIGH6DKF7v040STMRqjyy7PQL8CBi1Jj9eqseGcDXI9l8K9dobzCsiTPFmORfzJ2hXqSktVV4nROxJMdNxYqd1l3TlaKFc0Y3upUis3SBVnW5RpDpZXH3dDPETlhFm5FcqQ4v8wsZ4e8g3mcB57TLQJGWFPyUD8lfaOTslHJVNHcyvA66gmxqc9n3/66SSV7WyHtGtyfUQ1Id3w4wwJ9TVQFd7iBmjvzUPoL9WgLD3ZOcg/Ugv/HO59n52qmWPSNl7gw1X2jqbVR+zIrN2Z9NUdRBk70OaHiLui5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(5660300002)(6506007)(6486002)(31686004)(36756003)(2616005)(2906002)(83380400001)(186003)(110136005)(508600001)(8936002)(86362001)(31696002)(53546011)(6666004)(38100700002)(316002)(66476007)(66946007)(66556008)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU9YR2lqYlZBamVBRjQwa21vcm1ZSzVpbmppVnNMUndUWjNURFR4WWxxV2FE?=
 =?utf-8?B?Q2NMUllqbE4vZThsVGw0V2tieHZncjBCeWEvYjQzYmViQXlPeG5IWDB2d09t?=
 =?utf-8?B?R3Y3UWtyR1NBeGJvWDM3RUt5aFppN3lDTUlhOU9xV2E3Rml6VGVJeW1MbUwr?=
 =?utf-8?B?OHZUUmp3VFB6QWhhMHdsUTNzVUFCeWNzcE9aUXNWclBKL1pGVG9jcnhIM0xh?=
 =?utf-8?B?TWJHZHZqZzZUZEFiRDNlZ0NXNWhBR1VjSlF3YXkzSDQvZXhGTUN0UUdkU0tm?=
 =?utf-8?B?ekJFenRxbFBWR1c1WFdBdFdUK2Z4L3k4djJla0I0d0FabzNwUForNE54SXZY?=
 =?utf-8?B?dE80OGdOdEVMclJrbVpIajRGRzFxQjhxTUJjcXNTSDc5ZE9MaWNzQis1Q29U?=
 =?utf-8?B?SGs1M0Z4UVlzWE5zZUtySzJvSW1nZFlsT0dmeFNOY0wyVUtzejlweTJkSlBt?=
 =?utf-8?B?djJpL1VEbkVQT1RPeWJlMGptUTZtc0pnRVFUWGRUN01DcVZZdzdNbWJzcXpB?=
 =?utf-8?B?dks5Z3IwbHRPeFRaNDlwZWFhaFloVWxCUHgxVm0yRGx4N1c1dnNQMWZuL2k5?=
 =?utf-8?B?UUQyWFdsWFRlOHhvcnh6NUhsTHNpcjNTZGR0SGFFVHZWaHBmVjZrSlAxS04w?=
 =?utf-8?B?TlM2c1pNUHVSVDQ5NVYrOTJkWW5XU2Y3ZU93Q2VWd2NQaXlIaHJxWlpOVTcx?=
 =?utf-8?B?TFRKdkhNa1crazBXcW9nNE1xVyszOCtQY29KZHJWUWpNeExpZnpBa0NpQUI5?=
 =?utf-8?B?Sk9XcjdyTWlMUWlCVW9qNXRPMitPQ0VCYkl3eHRMdlZtNEYvc1ltK29haFdF?=
 =?utf-8?B?QUd4OUZpUm9mbnhwUTFNdHI0dW1xS0poTm9XaVVubVNOYUVudHJwSmZkMW9B?=
 =?utf-8?B?NnpaRjBpQ0F0MmVSRkZRM1BZT3FGMXBIWnBQdkxmUDk4QXVxeVEvVy9DS1Vj?=
 =?utf-8?B?TjlhZGN3MnVDd3lFVHhRNjlicXVSbGZpWXgvSXhGU01LM092TVFVakw1QWc0?=
 =?utf-8?B?V1lBdlliMWNoQlZZV1dIalJpeTRJVVArdU5XeUlubUpVZWJMNkV1eVdVK0Y4?=
 =?utf-8?B?cTQyYXRxeC9FV3NiMi9vNlJQZkxzbWNWbldjVmVDYnR2dDhKWVdVV0ZqNXo3?=
 =?utf-8?B?NFZoZS9iSnJNajNyVlBPZE1uWUhMK0hxNVNOY3VjRy82akp4Q0VNL2lDN2FT?=
 =?utf-8?B?YXJMSzZZdFlYaWM3Ym1JZEhNK3RNSUZKR1J1VlhLbHhNMVU0cExYQ3ZoYlJV?=
 =?utf-8?B?QS9URjFlWWNjc3RJSzYzRVdxK2JjVXZ2RlBPZ3lRYy9XVkw2U1l6TS9GTG5m?=
 =?utf-8?B?bE1TY29tT2pUeFIrU0J0ZGJHbmh5dWg2RFhpQnI0WGhQMlNpUTN1MFFBR3B0?=
 =?utf-8?B?NzBFSnNvUC9vZ2JQS0VUQ0E4bENmOUFjamRTL0xPS0F4WVRabU9vSVNkaGFD?=
 =?utf-8?B?SlJLZGhPWEFNRHlHZTBmSEtWaVNqUGFIYjF1SjVZQXpJcHlGbStYN083ci94?=
 =?utf-8?B?T3dnSmxnMkRFVzBDWWhxbGNJd1Y2WFl2Z2psajM2NGRKelEzeldsWUI4akVP?=
 =?utf-8?B?Yk5tcmdZbnJQZC9NZkZidWpNamxLSWZ0aldnaVBFbEU3aFQ4czNiUXBsYXBO?=
 =?utf-8?B?enZKeElGMVFEQlpZL2FIWGwwTTRId1JxM1IxM2kxRjA5bUtCdk5DNHFDUzRE?=
 =?utf-8?B?cVhua2EyVWxUcGxwS2N4STBmTTJibkhvRUhkY0orLzgxb3hzZmpTYlhNTHh0?=
 =?utf-8?B?Wjd0ZlRpcUtQZTgxSGZGMnV4dnVMUTBTcjhSRmRiOWVxUW1DN3pTS3E1d2cv?=
 =?utf-8?B?aDVVUm56R0RxSFlDbitROGZGLzZ5dnNuTExybklVK3c4UTY2SmZiUUFwTi9r?=
 =?utf-8?B?ekhuZ2E5dDFDdHB3RTNJYnUzczYvcjJBaWNrbHY3Si9iL2ZKWlpaczZSc2p6?=
 =?utf-8?B?R3FoSHJTZFdGNmFPRzZHSlg0WkRCMFpJbkpVTFdwUUNjVE4wWTVoUEtSdmpi?=
 =?utf-8?B?bXpGTkMyUGNiK1FlM09laGU0Rm9YNytvekpJWkVycE03cmRoOUU2SDBTcjZ5?=
 =?utf-8?B?ZFNtQ3AyMUxsWnltcVdNV3VBb1VQVThUakZhRmhpNXpSQlh2WVlISXd4S3kz?=
 =?utf-8?B?cy9vVlJXZWJPSW1lRmdMcmlSVTlJeWkwWW1HSlpKUkdXR3Y0UEM2dUxxeXJo?=
 =?utf-8?Q?r6qYKcGsURBSvRh+zUm3Ii0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706b98d6-df03-43df-0caf-08d9fc323d8c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 09:51:36.4850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0Q4/Y/WBb8xWxCPN6mDmYpLavrAq/7gIiDUh/pVA3O9F8dZ7xVMmJ4WDE098/4v6VBElyUPu2MT9S8V7xOOfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1519
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 3/1/2022 5:43 PM, Michael S. Tsirkin wrote:
> On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
>> Currently we have a BUG_ON() to make sure the number of sg
>> list does not exceed queue_max_segments() in virtio_queue_rq().
>> However, the block layer uses queue_max_discard_segments()
>> instead of queue_max_segments() to limit the sg list for
>> discard requests. So the BUG_ON() might be triggered if
>> virtio-blk device reports a larger value for max discard
>> segment than queue_max_segments().
> Hmm the spec does not say what should happen if max_discard_seg
> exceeds seg_max. Is this the config you have in mind? how do you
> create it?

I don't think it's hard to create it. Just change some registers in the 
device.

But with the dynamic sgl allocation that I added recently, there is no 
problem with this scenario.

This commit looks good to me, thanks Xie Yongji.

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

>> To fix it, let's simply
>> remove the BUG_ON() which has become unnecessary after commit
>> 02746e26c39e("virtio-blk: avoid preallocating big SGL for data").
>> And the unused vblk->sg_elems can also be removed together.
>>
>> Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>> ---
>>   drivers/block/virtio_blk.c | 10 +---------
>>   1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index c443cd64fc9b..a43eb1813cec 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -76,9 +76,6 @@ struct virtio_blk {
>>   	 */
>>   	refcount_t refs;
>>   
>> -	/* What host tells us, plus 2 for header & tailer. */
>> -	unsigned int sg_elems;
>> -
>>   	/* Ida index - used to track minor number allocations. */
>>   	int index;
>>   
>> @@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>>   	blk_status_t status;
>>   	int err;
>>   
>> -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
>> -
>>   	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
>>   	if (unlikely(status))
>>   		return status;
>> @@ -783,8 +778,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>>   	/* Prevent integer overflows and honor max vq size */
>>   	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>>   
>> -	/* We need extra sg elements at head and tail. */
>> -	sg_elems += 2;
>>   	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
>>   	if (!vblk) {
>>   		err = -ENOMEM;
>> @@ -796,7 +789,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>>   	mutex_init(&vblk->vdev_mutex);
>>   
>>   	vblk->vdev = vdev;
>> -	vblk->sg_elems = sg_elems;
>>   
>>   	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
>>   
>> @@ -853,7 +845,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>>   		set_disk_ro(vblk->disk, 1);
>>   
>>   	/* We can handle whatever the host told us to handle. */
>> -	blk_queue_max_segments(q, vblk->sg_elems-2);
>> +	blk_queue_max_segments(q, sg_elems);
>>   
>>   	/* No real sector limit. */
>>   	blk_queue_max_hw_sectors(q, -1U);
>> -- 
>> 2.20.1
