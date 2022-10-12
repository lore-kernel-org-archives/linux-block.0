Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EADC4332F
	for <linux-block@archiver.kernel.org>; Wed, 12 Oct 2022 10:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJLKB3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Oct 2022 06:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJLKB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Oct 2022 06:01:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA826AE861
        for <linux-block@vger.kernel.org>; Wed, 12 Oct 2022 03:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQnasYV+/F/f/2K8OaM3Ot79fEwF2im9g1wYxklKFNVl20nsoHsm65neSnzmId7EZ03yC+uStB3sKwYCJ+n0ItLe9UiQjwUgJWywuHhN7qlPc9jf9qQNPckyvrBKScuoSyUid2j2vTp/CYlSRpvzYB0sa6jzPy5XCIGfa8hpNKgJlmSJy0k+/7tgQTy6hSgy8bL+4zplapE5/MqqYGsU2CqDycmf/gofjDJSg9o7s/bBf9atSc9QxXojgOyw+GIOs8ZIuHvxIygO05JiGLVk8O4m3khZkfQeuFIi2ZgMMXnWYGKYqTzddzercCyuL8HiL0rquSg4ZNMbG+JenAdaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFBPu/9MXOWTgJmw1EIzTPYmYk8UmVbpsD/VmP6FmTI=;
 b=lok39uuSDlnfQiO0TTrjwmqK8lOZtbjlT3EjtJSNZNgKNfNOj3crjUD2NUoehtBcck/h1A81zpxkPf3tdR42FqxqWraMkqMqbLGmMYqC89tzFOeAyc30phbLDLvjdBog8946HUHwhgK0EaRhzYEvaKRX2ABjvqeveAbO3kyiEBk7tEtSKj6Tkl5Sm4kqE4ichmr8/y7MXcJyK1ebTyUTYGs1RxWZG7BcqITXhEV/Ms3xH1pNN/LdchFwt9xXXkA4j7qoX5oaaRRna6AEWfLXwYqRDb1OV/HWryIoLRuXW2hQ4b3XokfEtpxvwlh8kqVjPG/7NLGX4oCDIg0WH1BuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFBPu/9MXOWTgJmw1EIzTPYmYk8UmVbpsD/VmP6FmTI=;
 b=LiZDYRuYHBGqJMSuXeLeBOUuaiW6qWN88ualhpF5bTVfDNCckrCmyE1kJsiymY8KUmoWhsIwE0R42TWHectm2HiEk2Hoig3F898Kf9aIel+/ExfZvRaqpU/6+Ax3JhEJpJL21HWF6sy8u/4fYsB+EmQMi8c3LIak4U6DhrDw+O3KlGFiLaQJodBJNB7U2WLhvHiE5L0Yy9JHh8k1Rq0dfIEBb8tXnXcVsiAVUJqgiY74hlKpOjCd9QQ2dap2rXdyhGW4zW8unL7n2aZRJaZjy3V4cu1AUrvMsTAGS30ayC2UE7hWDhh57DLwaq8REIhabE5BS41Tt6BdMwL2TDmDjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 10:01:25 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb%6]) with mapi id 15.20.5709.022; Wed, 12 Oct 2022
 10:01:25 +0000
Message-ID: <f0e8e8a5-74ce-e62f-78f2-afb63663345e@nvidia.com>
Date:   Wed, 12 Oct 2022 13:01:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] virtio_pci: use common helper to configure SR-IOV
Content-Language: en-US
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <20220928234008.30302-1-mgurtovoy@nvidia.com>
 <20221012010143-mutt-send-email-mst@kernel.org>
 <642b7167-2c1f-c7df-a732-0603da92579a@nvidia.com>
In-Reply-To: <642b7167-2c1f-c7df-a732-0603da92579a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH2PR12MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 735d87be-5300-4574-be1e-08daac38b932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6aYClQa37KHINI6gYtKBLU/pPr3DVf7reSBWhlqPPuu76av6LLcNVnx3NUseirQnz01Xok0LB/yPS3h6FzOwWCofHgYWH+Xm3BSaCeEiX3Idcxg3Y1Xam1jnM/no4v509qhXcFymGqiZufQEhJwsIYk0av8w/6JNZz5UGG8tDxTjkCj6fK1p1tbXm8dOGTkcwNoO79IEHP6jjrjgQxlEtzIIUce4/0iQxWCGWRsNFzEookS2w62/HYDP9Uh0EJHDom/zFvQx+RJwXyZO5vTSJ6PTS5ZMsMWVbEQOCSoWDGI9JTbBF1ylGadh3Do7KH8fFyDqgSQ0khkQGvulEgMZg51at4SFg6ZFcMfm6SEIb2ABkl3ncwbW1gIben38Tw9gwh3A67i7dQaqYrK1qqJrW48H8CLSg6JA/v94TIjf9rmyAgz7Be/VwEvNxhowcaASTFe1Zs2uwV26barWXgd78CGf24I7rKGyfsZ5h1/O7XmmsgratJ9RS/Q/ixgcqjI70HLzWDorj3NVVGXX6M2CElAuTwfsK97fS0VcohvSFyBXshTnsT+MVNaAPbfC7qczzR+mDqVpitNPsu+kl/iV6jK9q/9wSNqSlT65UGzSI3b25V5JW///T4lkTU1inKzMRqPaSNFfazx9CgYlS7P8ww6HBlKOTwBQuW7La7WUzEQ9bKHk/MdZvLaMGyC8p2MCYNpooI4YsYEYUJdPJ9ZLIEYjajaZgX2OSgjJPZ6/PzDgOLK6GwqAIj71NQIDkIk9wEHFbXL+MBovwFqBuApftMjqjl29W26QW23K2FwaacoSeKO/BNBa6Vu13OpHe9NTe26dhMxtfvzHSK0ZqQpRgEHhk750Yd8oh1h5PVwClaBhgX/YYForz7LNNJz7Odt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(31686004)(6486002)(966005)(38100700002)(110136005)(478600001)(86362001)(31696002)(36756003)(6512007)(316002)(83380400001)(26005)(53546011)(66946007)(66556008)(66476007)(41300700001)(6506007)(5660300002)(8936002)(2616005)(2906002)(6666004)(4326008)(186003)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXRjTHJzdXdJaGNkZ29PVjc5d212ZjFLZExDQ0JEWWgwUTgzdldERFZaMUR0?=
 =?utf-8?B?NExaa0hhZGN5RUlvSUpvc1NnY3M3S09yTWdBbklnQUZDY3pRWkhYL1JMNk8y?=
 =?utf-8?B?UnRwN2wxckNIZ084VkhwZXVtOHc0Y1FUSS9NR2dteE1TRmtPNjkrRTNjcVBB?=
 =?utf-8?B?bGRvTE1JZUd5cDNTcUpRcjFsT00yQWxMdE9wVWwyS3dQWWMxdmQrdWlOQmZH?=
 =?utf-8?B?bWV3NFpjMFBQTWN0akRmWnpsby9ndUdxN3UvMDZzRENQNzdENWM2Sm9NaGZ3?=
 =?utf-8?B?WUkyNVpic0FXcnNJNjY1YVZta3dsMVFRUGVBelhvZ1BiWmdHV3g0ais3N2Rh?=
 =?utf-8?B?MmRaV29LUkNFa2R1TzZ6VTZ5cEFkTlFldTJuVzdWRjB1UEZDc3d1OVFmM3Ny?=
 =?utf-8?B?RFh4dlhHemRhUWZsWnZEaXNNQWY2QmRmVTF5cHF0N05RNFhwcmhHMXRtdkIv?=
 =?utf-8?B?VXQrdksvQ1c5SDhNTlVPMWRjNUgzeWhrSnNTVStWQ0FrckI5aGhud2Evb2xJ?=
 =?utf-8?B?amszVzlGR3R2S0R4K1VWU3h3bHB2RUl2THdsRm16dlVKKzNwOVc3aGVtZVkw?=
 =?utf-8?B?eTlsYkhKTno2ajgvWUs0MGRvRFJiSzZjVksveGZxSmFjK01ISWZQbkc0ZExM?=
 =?utf-8?B?Wmd4U0tkdmZwaS9YUWUva0lhK0FtdDd1T1FXQVluWjcyQ2RKNDNuTUk0Zk5R?=
 =?utf-8?B?d0VYUEdRMUZwTloxeGlrMXh0WXJaMEMvcEtoSzBsTWZvZkJnN3hQcXhDZ3pz?=
 =?utf-8?B?N1ZudTFzZzYxazdHY1krTkVDeGJnd005WE50M2tEWE1ucFkvR1FxeXdpYWV0?=
 =?utf-8?B?V3prY25ibG1kV0FNOTdtTTZPaGkzWlcxTVg4ZU84aWUzSENvWGttWGw1VEtl?=
 =?utf-8?B?d0FjRFplanJmaXBIRlE4M2YwaXQydEY1NnZuTlRGdTg5ZksySjZzSGlFZnJs?=
 =?utf-8?B?NUNscEZvcjFsdnJMQTRlUmI5U2JjWXBZVFVINUhTU1hEM0kvWEtUSTJ4MnY1?=
 =?utf-8?B?MWh6TjZ0OVcxUE5ybE1xWWFmaHpicDRqaWVSRTVCK2plM1F4U0NBZ2tKYTZG?=
 =?utf-8?B?SDFFcG5YQ0JiY2JtQlYzb0FkRDNHNnZPQ2taZUNDN3ZWQmUwaW5KQUdFQnR4?=
 =?utf-8?B?c0dsbXlwU0VkYzVMVThrQkZXcjZuaWp5UmlLYnZucm15aEx6cENCaFgvWnpn?=
 =?utf-8?B?YSsrUWNwQmwvM1F1bStuazh5S3RXaS85Wkc3WnBJNVFDeGVpV2YvTThoK2FZ?=
 =?utf-8?B?d2ZuRWUySUFWU2VJUGh2WmRMcUdiUjBIMFJkQjdNYkFrVE04eFlrRDZQazdR?=
 =?utf-8?B?Zlg5R1FvazVQZFJjNjRQN25hakIrUWF6RGwxZHBvYk5zbW5ZczkxT2F6OGdN?=
 =?utf-8?B?QjZEYS92Q3JwQk9kaUFzNTl4YmRTTEw1NDZ0R01QYTJ3QyswZ1Ayd3FMOGt3?=
 =?utf-8?B?aldQNmFud0lrMGFtdDE3VXhmSjdMbnc3S1hOa2IzQS91RjBSa3lhSWUvUTdp?=
 =?utf-8?B?WGphZFAxdXQwcGpaQXJRcUJTck91dVNLdVE0ZzBGd0hEN0lMNkErdDVGejVx?=
 =?utf-8?B?SWUzRGFQRGVKWWhEeFFkTTdDZkNRTWh0M3BTZ1Z3M01tUnpGMlUvU044eVJ0?=
 =?utf-8?B?TllFLzBYZUxGUTc2YXFtdlZNQmE3bXQ5akhCVG9jeEJOZTNRanlYMCtHSDN6?=
 =?utf-8?B?TlBMR0FyQjNjOHdmTjlOZVpDczhzZXBhNDBxWUNpWTJJVXJrQ0Qvd0U1SlRx?=
 =?utf-8?B?Q0w4aDFNdFNRSkg5akt3b1dDWVdQNldEenV4d3JPWTVLVkdpeUc4Ti90NGNh?=
 =?utf-8?B?eWpzeHFOWENWNnhnQlhBdFlwMnlwTWpvazExV1RlTnIvU2x0ZHlyRXBQQktE?=
 =?utf-8?B?dWcxQ1lacXdoUGFjZkJqckZ0cG1McjNSVEl5Q0hoOHNocytNNmtWUkxPOVha?=
 =?utf-8?B?VEs3dkhPWEF5NnZqRjZHM1MvQVhKd055aTA4VUE5M0RVam4xTGNSU2h2NTVW?=
 =?utf-8?B?eGViLzZMM3dESHkxRnI2YWVmNEpGd0sxVkJWRExOb09XdkJTRVdIT3h0TmVN?=
 =?utf-8?B?TXVDK01FWnRIRDIzVkJ5RVlTR093bXFROTNXTENaS0lWeE54YlovWU44Q2pE?=
 =?utf-8?B?dnhPNFVhNHZPWHoxQkRnMkJXWWtrTmlZSG4ybHZ6bkdDWWpSaGc3LzNkQmsx?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735d87be-5300-4574-be1e-08daac38b932
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 10:01:25.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tS/h9EbbSTROuStOkK/KEobmr7mPWF4mGfZj9IxaCAo2/eDONSjXHApOyJNhdT8vKR5YpaXw15SCpUbfqZlsmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/12/2022 11:42 AM, Max Gurtovoy wrote:
>
> On 10/12/2022 8:02 AM, Michael S. Tsirkin wrote:
>> On Thu, Sep 29, 2022 at 02:40:08AM +0300, Max Gurtovoy wrote:
>>> This is instead of re-writing the same logic in virtio driver.
>>>
>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> Dropped this as it caused build failures:
>>
>> https://lore.kernel.org/r/202210080424.gSmuYfb0-lkp%40intel.com
>
> maybe you can re-run it with:
>
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 8e98d24917cc..b383326a20e2 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -5,10 +5,11 @@ obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
>  obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
>  obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
>  obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
> -virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
> -virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
>  obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
>  obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
>  obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
>  obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
>  obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
> +
> +virtio_pci-$(CONFIG_VIRTIO_PCI) := virtio_pci_modern.o 
> virtio_pci_common.o
> +virtio_pci-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
>

Now I saw that CONFIG_PCI_IOV is not set in the error log so the bellow 
should fix it:

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 060af91bafcd..c519220e8ff8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2228,7 +2228,10 @@ static inline int pci_sriov_set_totalvfs(struct 
pci_dev *dev, u16 numvfs)
  { return 0; }
  static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
  { return 0; }
-#define pci_sriov_configure_simple     NULL
+static inline int pci_sriov_configure_simple(struct pci_dev *dev, int 
nr_virtfn)
+{
+       return -ENOSYS;
+}
  static inline resource_size_t pci_iov_resource_size(struct pci_dev 
*dev, int resno)
  { return 0; }
  static inline void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool 
probe) { }

Bjorn,

WDYT about the above ?

should I send it to the pci subsystem list ?


>
>>
>>> ---
>>>   drivers/virtio/virtio_pci_common.c | 15 +--------------
>>>   1 file changed, 1 insertion(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/virtio/virtio_pci_common.c 
>>> b/drivers/virtio/virtio_pci_common.c
>>> index ad258a9d3b9f..67d3970e57f2 100644
>>> --- a/drivers/virtio/virtio_pci_common.c
>>> +++ b/drivers/virtio/virtio_pci_common.c
>>> @@ -607,7 +607,6 @@ static int virtio_pci_sriov_configure(struct 
>>> pci_dev *pci_dev, int num_vfs)
>>>   {
>>>       struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>>>       struct virtio_device *vdev = &vp_dev->vdev;
>>> -    int ret;
>>>         if (!(vdev->config->get_status(vdev) & 
>>> VIRTIO_CONFIG_S_DRIVER_OK))
>>>           return -EBUSY;
>>> @@ -615,19 +614,7 @@ static int virtio_pci_sriov_configure(struct 
>>> pci_dev *pci_dev, int num_vfs)
>>>       if (!__virtio_test_bit(vdev, VIRTIO_F_SR_IOV))
>>>           return -EINVAL;
>>>   -    if (pci_vfs_assigned(pci_dev))
>>> -        return -EPERM;
>>> -
>>> -    if (num_vfs == 0) {
>>> -        pci_disable_sriov(pci_dev);
>>> -        return 0;
>>> -    }
>>> -
>>> -    ret = pci_enable_sriov(pci_dev, num_vfs);
>>> -    if (ret < 0)
>>> -        return ret;
>>> -
>>> -    return num_vfs;
>>> +    return pci_sriov_configure_simple(pci_dev, num_vfs);
>>>   }
>>>     static struct pci_driver virtio_pci_driver = {
>>> -- 
>>> 2.18.1
