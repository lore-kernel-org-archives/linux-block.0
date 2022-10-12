Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7233C4332F
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 08:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJLInD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 04:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJLInA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 04:43:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9125B5FC6
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 01:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chnY3PbvT8wdJLZ6OZ+aUnb8KgzzWE+Bqb8Doa3fKcnrkXGOMpCzbi4re0MaBXpqo0kcNtNN4UrqHI0xgxphTpousifp+ZBJT+1UIctJ3RIjtNJ1HUwN/xHj7x6mMGVLgEqPGIMu7OMzYBgqGzFHmoEV8PWbcD3AdoRrBX6PTMhX16sRfGbcJWgYDSLXaYC6BGbgHMVAT+OAUkPcSvtzIQPQ2azrp5GhxXPEtSj7fMspscQwBaeOvGUT/g+7K12ZLllunTIIbkycMXymOhh3+/g9AcBpiziFu2lSLYO5//7nb5MuC4CFpMylbWHYvSzyaiemJ35XWTbJSNr+q4XyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP2XVTxhYK/u/0U+ijend2D2E2BlhYe8MhJpfgP12/k=;
 b=QE5cC2mFIfwHXCPTLyz7SSnUpxTsDWPw8AOxTSwGwMgbctccYOVIiQ+P6Y54atUbm8gL46FNIE9ijQyn6XEL2LjffY0GXrnjoG5SR/JceaRL1f9BdbdaBi906XMqV6e69fB7CHrG5kEEvN2HnnTP5fCWkiY9xXwVeJuROxxhoOt2TzmY/TIGh6JLOU+CZPCrMBeOz23zm7mrWq79rragopjdklErUgLzlRsWgH67soN3CaQpriswSmUhmbbJEmM5jJVXoTAIQuUK75e5Q2SK14x6j0pawDA8d590tZtlitVxWF6DoxFKkisyr6NaKDdVBUZxpGnkb7cjOq9yU0NjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GP2XVTxhYK/u/0U+ijend2D2E2BlhYe8MhJpfgP12/k=;
 b=Z6XdI8mi9qCt/zsPamexN2tmpjKzcJgJDZe5WISCkarISl94BlLj2BBm0e7EsQCca3USCTlxvDGQwl+6u95MrQt2S+f6wEvS6H1Da/S1jwO4sab3gPCS03nSbREZzQzMXReimrCREXHadlVX1bfs+1YlG0Zz21+wti1Pyxip5O4LIz2GCxjFvEF23YKZixjPyhkTuDusBSBZ9hpqWnIXxKjvN21XszmL/F5wwBtF2YWLOJydG9NddzXZqe0gsM44IyJvKcKcfnYSdXiVcRVi/zYhPx4jqJBAEnbns6RrBJes7zUQHrYRzhDiRS9PRWyYlayvlajG9+DbtvohhHIw3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.21; Wed, 12 Oct 2022 08:42:58 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb%6]) with mapi id 15.20.5709.022; Wed, 12 Oct 2022
 08:42:58 +0000
Message-ID: <642b7167-2c1f-c7df-a732-0603da92579a@nvidia.com>
Date:   Wed, 12 Oct 2022 11:42:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <20220928234008.30302-1-mgurtovoy@nvidia.com>
 <20221012010143-mutt-send-email-mst@kernel.org>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20221012010143-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0266.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::15) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM8PR12MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: 15eea28d-1454-4cbf-5fc2-08daac2dc37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /omcK1VJsY08NyAvdb3c14iwn3uHpQM89muboXFkkablAG9zgApJpwh9TVcXEAD/c4j4J+CmzXGPjDxZYhvOTD3ZlzeeiQ/O6rDngERnwgfeC1lBOvmFIKHEhvexgHh41sRgKALYClq3iiVdCxOzvx6M3nkdqXDMB1vBxoYdPXjIBQRr+NrJCrqygczIlydQXfe9k1N5X87UHtS23fc8IsgaskKibByOti4IEm5Ibyb9tK57PJ4MwIGC28YQ0k4xK58uRwhSlaIbDDoXbPia0IxDSmgjZ/lff33pup6Lf2iA/gKR02U6MZzqFf/68bHGLjVb83vV5Dt6atbzFAkP+BBtk8F/tygaw3NO9M1isP4zZtxBwNkKTybEntQVf+7aHI4IH1uTH2ypdDJ7HhS740N20ESlndyjEoiKyqB2cDaazfnUKlG1nBcfgyHzXi6DKoWoYZCd9Mr4fK/3MdAR2Amy1T9/pWjPdUNn56fvQMg0C5Cagiwkr8Zi2fNWB8/eJ9nJqvUSBQBqhbanpCldKZmnAoAO547BC5DUvn5VF95itQO6WJts8bxudf3Q5tVBXpkwODs1/wi7NoIMRtPlu2kYcxU2WlukzgUP16woHOylNK1+hIUOC9QFWVkxxXv8VkVle6wahseWRhk0FgreKrH9qPqqV0lv7XIhTu7YUnbFNse0c1VKB3JfG0wTBVL43b1CuRr2tPvpfWiQcTlUvgGD1nDJsK0cZW8uvpXDc7sarMyUXub/ZVasJ7eB9eqIWnffEwVyoNdggGWubIIUR9EqqliRMY2OMMfah+aPuoosk+dttE765BQjQc6OxltQhPoSzmex2ymfP+RGw7JWaH8KVbqWIZ5epboUYyBcATSyxwx6jb/XtS9YyqzdHzsm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(38100700002)(86362001)(31696002)(6506007)(6512007)(2616005)(53546011)(6486002)(966005)(478600001)(66476007)(66556008)(4326008)(8676002)(66946007)(6666004)(316002)(2906002)(5660300002)(8936002)(186003)(6916009)(83380400001)(26005)(36756003)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2FIVnY4a2JUN3FzcjBkbEM2QnFxMHhNU1Q2MVZzM1A0T2RwTzZXZjJkZjlY?=
 =?utf-8?B?WklMRmhIUGNPT3ZoV1oyeGNaRDhvTXpQRDJoREJrZUxTSktuY21CeVEvZnVC?=
 =?utf-8?B?a1Z2MzZONXI1VWszV1kycnJUSEM3b1Z4ZG0vODZnNG1UVXg2c21YTDdMdlgx?=
 =?utf-8?B?UXh1b0s2SUR6RG5tN1JuU0tPRDFYcTdGUWRqS0JuaWhvbVhZb01HWmNjNDBE?=
 =?utf-8?B?K1BoWUIvcHhXYS9XOElMbHoyRHJBSVE1WlVQTGZ0SW5TR1ZJNzRTMTZGRkNW?=
 =?utf-8?B?bzN3bjZFK0NTY1RsUE0zOWJYL1hYbzdldC9mSjZoblRGSGd3S1BOUXFObjNo?=
 =?utf-8?B?WFRZTjdsSVBIWlk2ekJiakZYUGRQNGNodWdJbHZhMkppdzJTLzJJVWZXNHc0?=
 =?utf-8?B?cHFmckJ1V0hvVTg0WHdaY0lFOUVOM1IvVzB0OXFDemRrNk04cEN1OHNmMVkz?=
 =?utf-8?B?eUM2VjFRenpabitLd3Zxb0lHaWdjbWlzUG9KaVJNcmdUZzlzcHVSUDlRaEF1?=
 =?utf-8?B?NmtHczhKVW01Q1ptK25NNVRqRDJudmlkYVVPVnZSd3h2MDBsN09LRnh6ak92?=
 =?utf-8?B?Ymx4MzhCTFNzdUU3WndRNmdiTGc5TzY1bWxqS2VzNnp0Vk9hY1k0bjhqY3RW?=
 =?utf-8?B?UGVDZnBSVEkrcXgvNUlOajlPL05WaXJwbXUyb3VXaTdRR09ZUTgxb2JjTkh5?=
 =?utf-8?B?dFZhejEyRUZ3THdYS3VSaDlTQ2k5LzBPUjM1dytWdDJZUnpaQkVMWEF6ZGVh?=
 =?utf-8?B?Yy8yczVRWG5qd0F6akNONnJncVNHZUlLaFZKenJiSXNkaFJQMEQxTkhFRjhT?=
 =?utf-8?B?M2NROFAwSXhVVUV3V0wwTXV5RzJmOVVYR1BNeGkyYTBOT3JCY0ZreU1zUVIw?=
 =?utf-8?B?TE9ZazdXK2pwUWxFdEpJR0k1Ri94b3RqemUySGZNbS9neTljK09la1doQita?=
 =?utf-8?B?cmpZMG04R00rb0hkRTZYSFVzdTZoU1p0MXQzWHF6bENCcSsxdjNTeWZ4ZFpY?=
 =?utf-8?B?bWc4cnA0OHplcTJJWXdoWkkvdGIwMURRbzdWTUozVHhmNWxMaC9RNWRnc3Bi?=
 =?utf-8?B?STBUcGtvdnpSaWV6UjdJbVpKUGVlK2xlOWNFV1hBWFg1WTYrYThFQzAvdkMr?=
 =?utf-8?B?eUU4dU1aQ1pYV0NHL1pyNUVGTWNVUUZuRnluQzZZYUN4WEpUNEMveW5zdEN6?=
 =?utf-8?B?RkFLNThTUG1TZVpIR2ZFRVZTUVNOZjVuVE1UQ1lWbTc1ZDJiTUp4anJITC9n?=
 =?utf-8?B?MU1qTDJteWtGbW43SnFNWmpLZ0lYZWtwSXBBSWlCMEt1T0l4K1FrdW1mbU9X?=
 =?utf-8?B?VHdhcUZ0UUNYZVU5Vk1Oc0Y1a1ozQ3hoYjJteVdvR09XdTV1VWtQMzNZbWdk?=
 =?utf-8?B?U1VxbzRJb2lVN1o5ZjlSc0xCY01VS3NaWVhtQUtVZmFjMVA5bkl4WGFOYmxB?=
 =?utf-8?B?SmdrbDE4elVsTFA0L2NpN2dJUERCOGt0QnF5d3JQMjhFSGZzRkFUUnhFTU51?=
 =?utf-8?B?dlJOUThzUWp6Nnp2YTZpOTBNTzNGbFg5R0cvMWw0dGtyc2llTlpoNDE4WXdP?=
 =?utf-8?B?QzhReHlvcE1hKzkwc01qZ0IwV2R1b3ZtMmR0TUV6TkZkelZPdTBqeVVuQ3Vy?=
 =?utf-8?B?eldVYlM5SW9jN0NUTEVSUjN4bDJXYzdkenUzQ3dkSng5eW9od2VpWVNJblhI?=
 =?utf-8?B?MGlwNUJlUkRuUUVaQkpWRHhJbkhUZzVxenllMFpqNUlsTnFSdDBuUVZUTW4z?=
 =?utf-8?B?MjlIVHBkNWsrUUZzVVBtOWo3eWZLUTFpSFV1WUhWOUd2OWtMY3YwTE1URzJl?=
 =?utf-8?B?WldwL21FT0FQN2swUnlyaTZhMGpLNDgwMjJKcUkyNEQ4bno1ZGhRZmI1bStv?=
 =?utf-8?B?Y0lpTTRrTTNWK3R6NjVLT1NsQW9pN3lBTXd0ck9LbkFDdHFtVVB1VDNvQWFD?=
 =?utf-8?B?S1pQdHlMTFdnazVFWG9wTEhDZW02a0hhT3RoV1pReHVEa29MRFRUYnYranVZ?=
 =?utf-8?B?c3dLYXRGZ3l6Y2ZxUlZxZ01zSFMxa0R0cHFpeVdObXhxc2gzNzVRNzhwWDRB?=
 =?utf-8?B?akYvL3pLVFlrRDZtS3NiTDZPeEp6a1ZSWUtBOFY2bGlPZ3BMWjByMEtVZ04z?=
 =?utf-8?Q?KCAPtELsZTtTbMkePzR9Ex+Xr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15eea28d-1454-4cbf-5fc2-08daac2dc37c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 08:42:58.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiUOyjw7chPI0+69jo6MR0vahzOh3W7p2ZjYAt4N1IoU5AVmJ6cGS8Gw9iOCNnFSYoCD0TF+Gm7bZx7MexKvSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/12/2022 8:02 AM, Michael S. Tsirkin wrote:
> On Thu, Sep 29, 2022 at 02:40:08AM +0300, Max Gurtovoy wrote:
>> This is instead of re-writing the same logic in virtio driver.
>>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Dropped this as it caused build failures:
>
> https://lore.kernel.org/r/202210080424.gSmuYfb0-lkp%40intel.com

maybe you can re-run it with:

diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 8e98d24917cc..b383326a20e2 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -5,10 +5,11 @@ obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
  obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
  obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
-virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
-virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
  obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
  obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
  obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
  obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
  obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
+
+virtio_pci-$(CONFIG_VIRTIO_PCI) := virtio_pci_modern.o virtio_pci_common.o
+virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o


>
>> ---
>>   drivers/virtio/virtio_pci_common.c | 15 +--------------
>>   1 file changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> index ad258a9d3b9f..67d3970e57f2 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -607,7 +607,6 @@ static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
>>   {
>>   	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>>   	struct virtio_device *vdev = &vp_dev->vdev;
>> -	int ret;
>>   
>>   	if (!(vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_DRIVER_OK))
>>   		return -EBUSY;
>> @@ -615,19 +614,7 @@ static int virtio_pci_sriov_configure(struct pci_dev *pci_dev, int num_vfs)
>>   	if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
>>   		return -EINVAL;
>>   
>> -	if (pci_vfs_assigned(pci_dev))
>> -		return -EPERM;
>> -
>> -	if (num_vfs == 0) {
>> -		pci_disable_sriov(pci_dev);
>> -		return 0;
>> -	}
>> -
>> -	ret = pci_enable_sriov(pci_dev, num_vfs);
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	return num_vfs;
>> +	return pci_sriov_configure_simple(pci_dev, num_vfs);
>>   }
>>   
>>   static struct pci_driver virtio_pci_driver = {
>> -- 
>> 2.18.1
