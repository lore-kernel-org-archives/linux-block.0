Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37188 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755423AbeBOKUG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Feb 2018 05:20:06 -0500
Received: by mail-lf0-f66.google.com with SMTP id f137so33290012lfe.4
        for <linux-block@vger.kernel.org>; Thu, 15 Feb 2018 02:20:05 -0800 (PST)
Subject: Re: [PATCH 2/8] lightnvm: show generic geometry in sysfs
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
 <1518530768-20956-3-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <caa2634b-63bf-3a35-ed53-220aab2bd05a@lightnvm.io>
Date: Thu, 15 Feb 2018 11:20:02 +0100
MIME-Version: 1.0
In-Reply-To: <1518530768-20956-3-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/13/2018 03:06 PM, Javier González wrote:
> From: Javier González <javier@javigon.com>
> 
> Apart from showing the geometry returned by the different identify
> commands, provide the generic geometry too, as this is the geometry that
> targets will use to describe the device.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/nvme/host/lightnvm.c | 146 ++++++++++++++++++++++++++++---------------
>   1 file changed, 97 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index 97739e668602..7bc75182c723 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -944,8 +944,27 @@ static ssize_t nvm_dev_attr_show(struct device *dev,
>   		return scnprintf(page, PAGE_SIZE, "%u.%u\n",
>   						dev_geo->major_ver_id,
>   						dev_geo->minor_ver_id);
> -	} else if (strcmp(attr->name, "capabilities") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.cap);
> +	} else if (strcmp(attr->name, "clba") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.clba);
> +	} else if (strcmp(attr->name, "csecs") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.csecs);
> +	} else if (strcmp(attr->name, "sos") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.sos);
> +	} else if (strcmp(attr->name, "ws_min") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.ws_min);
> +	} else if (strcmp(attr->name, "ws_opt") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.ws_opt);
> +	} else if (strcmp(attr->name, "maxoc") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.maxoc);
> +	} else if (strcmp(attr->name, "maxocpu") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.maxocpu);
> +	} else if (strcmp(attr->name, "mw_cunits") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.mw_cunits);
> +	} else if (strcmp(attr->name, "media_capabilities") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.mccap);
> +	} else if (strcmp(attr->name, "max_phys_secs") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n",
> +				ndev->ops->max_phys_sect);
>   	} else if (strcmp(attr->name, "read_typ") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.trdt);
>   	} else if (strcmp(attr->name, "read_max") == 0) {
> @@ -984,19 +1003,8 @@ static ssize_t nvm_dev_attr_show_12(struct device *dev,
>   
>   	attr = &dattr->attr;
>   
> -	if (strcmp(attr->name, "vendor_opcode") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.vmnt);
> -	} else if (strcmp(attr->name, "device_mode") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.dom);
> -	/* kept for compatibility */
> -	} else if (strcmp(attr->name, "media_manager") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "%s\n", "gennvm");
> -	} else if (strcmp(attr->name, "ppa_format") == 0) {
> +	if (strcmp(attr->name, "ppa_format") == 0) {
>   		return nvm_dev_attr_show_ppaf((void *)&dev_geo->c.addrf, page);
> -	} else if (strcmp(attr->name, "media_type") == 0) {	/* u8 */
> -		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.mtype);
> -	} else if (strcmp(attr->name, "flash_media_type") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.fmtype);
>   	} else if (strcmp(attr->name, "num_channels") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->num_ch);
>   	} else if (strcmp(attr->name, "num_luns") == 0) {
> @@ -1011,8 +1019,6 @@ static ssize_t nvm_dev_attr_show_12(struct device *dev,
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.fpg_sz);
>   	} else if (strcmp(attr->name, "hw_sector_size") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.csecs);
> -	} else if (strcmp(attr->name, "oob_sector_size") == 0) {/* u32 */
> -		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.sos);
>   	} else if (strcmp(attr->name, "prog_typ") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.tprt);
>   	} else if (strcmp(attr->name, "prog_max") == 0) {
> @@ -1021,13 +1027,21 @@ static ssize_t nvm_dev_attr_show_12(struct device *dev,
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.tbet);
>   	} else if (strcmp(attr->name, "erase_max") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.tbem);
> +	} else if (strcmp(attr->name, "vendor_opcode") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.vmnt);
> +	} else if (strcmp(attr->name, "device_mode") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.dom);
> +	/* kept for compatibility */
> +	} else if (strcmp(attr->name, "media_manager") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%s\n", "gennvm");
> +	} else if (strcmp(attr->name, "capabilities") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.cap);
> +	} else if (strcmp(attr->name, "media_type") == 0) {	/* u8 */
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.mtype);
> +	} else if (strcmp(attr->name, "flash_media_type") == 0) {
> +		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.fmtype);
>   	} else if (strcmp(attr->name, "multiplane_modes") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "0x%08x\n", dev_geo->c.mpos);
> -	} else if (strcmp(attr->name, "media_capabilities") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "0x%08x\n", dev_geo->c.mccap);
> -	} else if (strcmp(attr->name, "max_phys_secs") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "%u\n",
> -				ndev->ops->max_phys_sect);
>   	} else {
>   		return scnprintf(page, PAGE_SIZE,
>   			"Unhandled attr(%s) in `nvm_dev_attr_show_12`\n",
> @@ -1035,6 +1049,17 @@ static ssize_t nvm_dev_attr_show_12(struct device *dev,
>   	}
>   }
>   
> +static ssize_t nvm_dev_attr_show_lbaf(struct nvm_addr_format *lbaf,
> +					 char *page)
> +{
> +	return scnprintf(page, PAGE_SIZE,
> +		"0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
> +				lbaf->ch_offset, lbaf->ch_len,
> +				lbaf->lun_offset, lbaf->lun_len,
> +				lbaf->chk_offset, lbaf->chk_len,
> +				lbaf->sec_offset, lbaf->sec_len);
> +}
> +
>   static ssize_t nvm_dev_attr_show_20(struct device *dev,
>   		struct device_attribute *dattr, char *page)
>   {
> @@ -1048,20 +1073,14 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
>   
>   	attr = &dattr->attr;
>   
> -	if (strcmp(attr->name, "groups") == 0) {
> +	if (strcmp(attr->name, "lba_format") == 0) {
> +		return nvm_dev_attr_show_lbaf((void *)&dev_geo->c.addrf, page);
> +	} else if (strcmp(attr->name, "groups") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->num_ch);
>   	} else if (strcmp(attr->name, "punits") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->num_lun);
>   	} else if (strcmp(attr->name, "chunks") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.num_chk);
> -	} else if (strcmp(attr->name, "clba") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.clba);
> -	} else if (strcmp(attr->name, "ws_min") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.ws_min);
> -	} else if (strcmp(attr->name, "ws_opt") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.ws_opt);
> -	} else if (strcmp(attr->name, "mw_cunits") == 0) {
> -		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.mw_cunits);
>   	} else if (strcmp(attr->name, "write_typ") == 0) {
>   		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.tprt);
>   	} else if (strcmp(attr->name, "write_max") == 0) {
> @@ -1086,7 +1105,19 @@ static ssize_t nvm_dev_attr_show_20(struct device *dev,
>   
>   /* general attributes */
>   static NVM_DEV_ATTR_RO(version);
> -static NVM_DEV_ATTR_RO(capabilities);
> +
> +static NVM_DEV_ATTR_RO(ws_min);
> +static NVM_DEV_ATTR_RO(ws_opt);
> +static NVM_DEV_ATTR_RO(mw_cunits);
> +static NVM_DEV_ATTR_RO(maxoc);
> +static NVM_DEV_ATTR_RO(maxocpu);
> +
> +static NVM_DEV_ATTR_RO(media_capabilities);
> +static NVM_DEV_ATTR_RO(max_phys_secs);
> +
> +static NVM_DEV_ATTR_RO(clba);
> +static NVM_DEV_ATTR_RO(csecs);
> +static NVM_DEV_ATTR_RO(sos);
>   
>   static NVM_DEV_ATTR_RO(read_typ);
>   static NVM_DEV_ATTR_RO(read_max);
> @@ -1105,42 +1136,53 @@ static NVM_DEV_ATTR_12_RO(num_blocks);
>   static NVM_DEV_ATTR_12_RO(num_pages);
>   static NVM_DEV_ATTR_12_RO(page_size);
>   static NVM_DEV_ATTR_12_RO(hw_sector_size);
> -static NVM_DEV_ATTR_12_RO(oob_sector_size);
>   static NVM_DEV_ATTR_12_RO(prog_typ);
>   static NVM_DEV_ATTR_12_RO(prog_max);
>   static NVM_DEV_ATTR_12_RO(erase_typ);
>   static NVM_DEV_ATTR_12_RO(erase_max);
>   static NVM_DEV_ATTR_12_RO(multiplane_modes);
> -static NVM_DEV_ATTR_12_RO(media_capabilities);
> -static NVM_DEV_ATTR_12_RO(max_phys_secs);
> +static NVM_DEV_ATTR_12_RO(capabilities);
>   
>   static struct attribute *nvm_dev_attrs_12[] = {
>   	&dev_attr_version.attr,
> -	&dev_attr_capabilities.attr,
> -
> -	&dev_attr_vendor_opcode.attr,
> -	&dev_attr_device_mode.attr,
> -	&dev_attr_media_manager.attr,
>   	&dev_attr_ppa_format.attr,
> -	&dev_attr_media_type.attr,
> -	&dev_attr_flash_media_type.attr,
> +
>   	&dev_attr_num_channels.attr,
>   	&dev_attr_num_luns.attr,
>   	&dev_attr_num_planes.attr,
>   	&dev_attr_num_blocks.attr,
>   	&dev_attr_num_pages.attr,
>   	&dev_attr_page_size.attr,
> +
>   	&dev_attr_hw_sector_size.attr,
> -	&dev_attr_oob_sector_size.attr,
> +
> +	&dev_attr_clba.attr,
> +	&dev_attr_csecs.attr,
> +	&dev_attr_sos.attr,
> +
> +	&dev_attr_ws_min.attr,
> +	&dev_attr_ws_opt.attr,
> +	&dev_attr_maxoc.attr,
> +	&dev_attr_maxocpu.attr,
> +	&dev_attr_mw_cunits.attr,
> +
> +	&dev_attr_media_capabilities.attr,
> +	&dev_attr_max_phys_secs.attr,
> +

This breaks user-space. The intention is for user-space to decide based 
on version id. Then it can either retrieve the 1.2 or 2.0 attributes. 
The 2.0 attributes should not be available when a device is 1.2.

>   	&dev_attr_read_typ.attr,
>   	&dev_attr_read_max.attr,
>   	&dev_attr_prog_typ.attr,
>   	&dev_attr_prog_max.attr,
>   	&dev_attr_erase_typ.attr,
>   	&dev_attr_erase_max.attr,
> +
> +	&dev_attr_vendor_opcode.attr,
> +	&dev_attr_device_mode.attr,
> +	&dev_attr_media_manager.attr,
> +	&dev_attr_capabilities.attr,
> +	&dev_attr_media_type.attr,
> +	&dev_attr_flash_media_type.attr,
>   	&dev_attr_multiplane_modes.attr,
> -	&dev_attr_media_capabilities.attr,
> -	&dev_attr_max_phys_secs.attr,
>   
>   	NULL,
>   };
> @@ -1152,12 +1194,9 @@ static const struct attribute_group nvm_dev_attr_group_12 = {
>   
>   /* 2.0 values */
>   static NVM_DEV_ATTR_20_RO(groups);
> +static NVM_DEV_ATTR_20_RO(lba_format);
>   static NVM_DEV_ATTR_20_RO(punits);
>   static NVM_DEV_ATTR_20_RO(chunks);
> -static NVM_DEV_ATTR_20_RO(clba);
> -static NVM_DEV_ATTR_20_RO(ws_min);
> -static NVM_DEV_ATTR_20_RO(ws_opt);
> -static NVM_DEV_ATTR_20_RO(mw_cunits);
>   static NVM_DEV_ATTR_20_RO(write_typ);
>   static NVM_DEV_ATTR_20_RO(write_max);
>   static NVM_DEV_ATTR_20_RO(reset_typ);
> @@ -1165,16 +1204,25 @@ static NVM_DEV_ATTR_20_RO(reset_max);
>   
>   static struct attribute *nvm_dev_attrs_20[] = {
>   	&dev_attr_version.attr,
> -	&dev_attr_capabilities.attr,
> +	&dev_attr_lba_format.attr,
>   
>   	&dev_attr_groups.attr,
>   	&dev_attr_punits.attr,
>   	&dev_attr_chunks.attr,
> +
>   	&dev_attr_clba.attr,
> +	&dev_attr_csecs.attr,
> +	&dev_attr_sos.attr,

csecs and sos are derived from the the generic block device data structures.

> +
>   	&dev_attr_ws_min.attr,
>   	&dev_attr_ws_opt.attr,
> +	&dev_attr_maxoc.attr,
> +	&dev_attr_maxocpu.attr,

When the maxoc/maxocpu are in another patch, these changes can be included.

>   	&dev_attr_mw_cunits.attr,
>   
> +	&dev_attr_media_capabilities.attr,

What is the meaning of media in this context? The 2.0 spec defines 
vector copy and double resets in its capabilities, it does not have 
media in mind.

> +	&dev_attr_max_phys_secs.attr,
> +

I kill max_phys_secs in another patch. It has been made redundant after 
null_blk has been removed.
>   	&dev_attr_read_typ.attr,
>   	&dev_attr_read_max.attr,
>   	&dev_attr_write_typ.attr,
> 
